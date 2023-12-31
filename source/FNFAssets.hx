package;


// A helper class to make supporting web easier
#if sys
import sys.FileSystem;
import sys.io.File;
#end
import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import openfl.display.BitmapData;
import openfl.media.Sound;
import haxe.io.Path;
import flixel.FlxG;
import flash.net.FileReference;
import flash.events.Event;
import openfl.events.IOErrorEvent;
import lime.app.Future;
import haxe.io.Bytes;
import openfl.display.MovieClip;
import flixel.graphics.FlxGraphic;
import lime.ui.FileDialog;
import lime.ui.FileDialogType;
import openfl.utils.AssetType;
import haxe.Timer;
import lime.app.Promise;
import openfl.system.System;
using StringTools;
enum Extensions {
	None;
	Json;
	Hscript;
}
/**
 * Assets reader and writer
 */
class FNFAssets {
    public static var _file:FileReference;
	static var fd:FileDialog;
	static var fdString:Null<String> = null;

    /**
     * Get text content of a file. 
     * @param id Path to file.
     * @return String The file content. 
     */
    public static function getText(id:String):String {
        #if sys
            // if there a library strip it out..
            // future proofing ftw
			if (!isInScope(id))
				throw "Tried to access a file that is out of scope.";
			var path = Assets.exists(id) ? Assets.getPath(id) : null;
            if (path == null)
                path = id;
			else
				return Assets.getText(id);
			try {
			return File.getContent(path);
			} catch (e:Any) {
				throw 'File $path doesn\'t exist or cannot be read.';
			}
            
        #else
            // no need to strip it out... 
            // assets handles it
            return Assets.getText(id);
        #end
    }
	/**
	 * Get json, auto checking extensions.
	 * @param id Path without extension
	 */
	static public function getJson(id:String):Null<String> {
		return getAmbigAsset([id], CoolUtil.JSON_EXT, AssetType.TEXT);
	}
	static public function getHscript(id:String):Null<String> {
		return getAmbigAsset([id], CoolUtil.HSCRIPT_EXT,AssetType.TEXT);
	}
	/**
	 * A safer way to get assets. Checks if the first asset exists and if not ALWAYS uses 2nd asset.
	 * This means backupID should be guarenteed to exist. 
	 * @param id The id wanting to be read
	 * @param backupID the id to read if wanted one does not exist
	 * @param type Type of the file 
	 * @return Dynamic The file, in the type requested.
	 */
	public static function getAssetWithBackup(id:String, backupID:String, type:AssetType):Dynamic {
		// backup id should always exist
		if (FNFAssets.exists(id)) {
			return FNFAssets.getAsset(id, type);
		}
		return FNFAssets.getAsset(backupID, type);
	} 
	/**
	 * Generic way to get assets
	 * @param id The path/id of the item.
	 * @param type The type of the object.
	 * @return Dynamic The file read in the type requested. 
	 */
	public static function getAsset(id:String, type:AssetType):Dynamic {
		switch (type) {
			case TEXT:
				return FNFAssets.getText(id);
			case BINARY:
				return FNFAssets.getBytes(id);
			case MUSIC | SOUND:
				return FNFAssets.getSound(id);
			case IMAGE:
				return FNFAssets.getBitmapData(id);
			default:
				throw "Unsure of how to get type " + type;
		}
	}
	/**
	 * Get an asset that could have multiple names/extensions.
	 * @param id Array of path names
	 * @param ext Array of string for extension.
	 * @param type Type of asset.
	 * @return Dynamic WARNING, if it doesn't find anything it will return null.
	 */
	public static function getAmbigAsset(id:Array<String>, ext:Array<String>, type:AssetType):Dynamic {
		for (path in id)
		{
			for (ex in ext)
			{
				if (exists(path + '.' + ex))
				{
					return getAsset(path + '.' + ex, type);
				}
			}
		}
		return null;
	}
	public static function existsAmbig(id:Array<String>, extension:Array<String>):String {
		for (path in id)
		{
			for (ext in extension)
			{
				if (exists(path + '.' + ext))
					return path + '.' + ext;
			}
		}
		return '';
	}
	public static function getBytes(id:String):Bytes
	{
		#if sys
		// if there a library strip it out..
		// future proofing ftw
			if (!isInScope(id))
				throw "Tried to access a file that is out of scope.";
			var path = Assets.exists(id) ? Assets.getPath(id) : null;
			if (path == null)
				path = id;
			else
				return Assets.getBytes(id);
			try {
			return File.getBytes(path);
			} catch (e:Any) {
			throw 'File $path doesn\'t exist or cannot be read.';
			}
			
		#else
		// no need to strip it out...
		// assets handles it
		return LimeAssets.getBytes(id);
		#end
	}
    /**
     * Check if the file exists.
     * @param id The file to check
	 * @param ext Extension to auto check against. For fine tune control use "existsAmbig"
     * @return Bool If file exists, true.
     */
    static public function exists(id:String, ?ext:Extensions):Bool {
		switch (ext) {
			case Json: 
				return existsAmbig([id], CoolUtil.JSON_EXT) != '';
			case Hscript: 
				return existsAmbig([id], CoolUtil.HSCRIPT_EXT) != '';
			default: 
				if (!isInScope(id))
					return false;
				#if sys
				var path = Assets.exists(id) ? Assets.getPath(id) : null;
				if (path == null)
					path = id;
				else
					// if it _does_ exist then yeah of course  it works
					return true;
				return FileSystem.exists(path);
				#else
				return Assets.exists(id);
				#end
		}
    }
	/**
	 * Check if a file is in the cwd. Used to prevent sussy bakas from being sussy
	 * @param id 
	 */
	public static function isInScope(id:String) {
		#if sys
		if (Assets.exists(id))
			return true;
		// If path isn't within cwd return false
		if (!Path.normalize(FileSystem.absolutePath(id)).contains(Path.normalize(Main.cwd)))
			return false;
		#end
		return true;
	}
    /**
     * Get bitmap data of a file.
     * @param id Path of file
     * @param useCache Whether to reuse assets if file was already requested. Only works on non-dynamically loaded assets.
     * @return BitmapData the data of the file.
     */
    public static function getBitmapData(id:String, ?useCache:Bool=true):BitmapData {
        #if sys
			if (!isInScope(id))
				throw "Tried to access a file that is out of scope.";
            // idk if this works lol
			var path = Assets.exists(id) ? Assets.getPath(id) : null;
            if (path == null)
                path = id;
			else return Assets.getBitmapData(id, useCache);
			try {
			return BitmapData.fromFile(path);
			} catch (e:Any) {
			throw 'File $path doesn\'t exist or cannot be read.';
			}
            
        #else
            return Assets.getBitmapData(id, useCache);
        #end
    }
    /**
     * Get sound from file.
     * @param id Path of file
     * @param useCache whether to reuse assets if file was already requested. Only works on non-dynamically loaded files.
	 * @return Sound The sound file.
     */
	 
	 public static function getSound(id:String, ?useCache:Bool=true):Sound {
		 #if sys
			 trace('loaded in sys bitch');
			 if (!isInScope(id))
				 throw "Tried to access a file that is out of scope.";
			 var path = Assets.exists(id) ? Assets.getPath(id) : null;
			 if (path == null)
				 path = id;
			 else
			 {
				 // prefer using assets as it uses a cache??
				 return Assets.getSound(id, useCache);
			 }
		 try
		 {
			 if(!Paths.currentTrackedSounds.exists(id)) {
				Paths.currentTrackedSounds.set(id, Sound.fromFile(path));
			 }
			 Paths.localTrackedAssets.push(id);
			 return Paths.currentTrackedSounds.get(path);
			 //return Sound.fromFile(path);
		 }
		 catch (e:Any)
		 {
			 throw 'File $path doesn\'t exist or cannot be read.';
		 }
		 #else
			 return Assets.getSound(id, useCache);
		 #end
	 }
    /**
     * Save content to a file. 
     * @param id File to save to. 
     * @param data Data to save.
     */
    public static function saveContent(id:String, data:String):Void {
        #if sys
			if (!isInScope(id))
				throw "Tried to access a file that is out of scope.";
			try {
				File.saveContent(id, data);
			}	catch(e:Any) {
				throw "Couldn't save to "+ id +". Is it in use?";
			}
           
        #else
            askToSave(id, data);
        #end
    }
	/**
	 * Save bytes to a file.
	 * @param id File to save to 
	 * @param data Bytes to save. 
	 */
	 
	 static function onSelect(s:String):Void
		{
			trace(s);
			fdString = s;
		}
		
	public static function askToBrowseForPath(?filter:String, ?title:String = "Select a Stuff"):Future<String>
		{
			fdString = null;
			fd = new FileDialog();
			fd.onSelect.add(onSelect);
			fd.browse(FileDialogType.OPEN, filter, null, title);
			var checkTimer = new Timer(50);
			var promise = new Promise<String>();
			checkTimer.run = function()
			{
				if (fdString != null)
				{
					promise.complete(fdString);
					checkTimer.stop();
				}
			}
			fd.onCancel.add(function()
			{
				// sad promise hours
				promise.error("user cancelled");
				checkTimer.stop();
			});
			return promise.future;
		}
	
	public static function saveBytes(id:String, data:Bytes)
	{
		#if sys
		if (!isInScope(id))
			throw "Tried to access a file that is out of scope.";
		try
		{
			File.saveBytes(id, data);
		}
		catch (e:Any)
		{
			throw "Couldn't save to " + id + ". Is it in use?";
		}
		#else
		askToSave(id, data);
		#end
	}
	public static function readDirectory(id:String)
		{
			#if sys
			if (!isInScope(id))
				throw "Tried to access a file that is out of scope.";
			try
			{
				FileSystem.readDirectory(id);
			}
			catch (e:Any)
			{
				throw "Couldn't read to " + id + ". Is it in null?";
			}
			#end
		}
	/**
	 * Ask the user to pick a path to save to. Used on web when other save functions are called.
	 * @param id Path to save to.
	 * @param data Data. Can be anything. 
	 */
	 public static function precacheSound(path:String):Sound
		{
			return getSound(path);
		}
	public static function transGraphicData(id:String,bitmap:BitmapData,?allowGPU:Bool = true){
		if (bitmap != null){
			if (allowGPU && ClientPrefs.cacheOnGPU)
				{
					var texture:openfl.display3D.textures.RectangleTexture = FlxG.stage.context3D.createRectangleTexture(bitmap.width, bitmap.height, BGRA, true);
					texture.uploadFromBitmapData(bitmap);
					bitmap.image.data = null;
					bitmap.dispose();
					bitmap.disposeImage();
					bitmap = BitmapData.fromTexture(texture);
				}
			}
			var newGraphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, id);
			newGraphic.persist = true;
			newGraphic.destroyOnNoUse = false;
			Paths.currentTrackedAssets.set(id, newGraphic);
	}
	 public static function getGraphicData(id:String,?allowGPU:Bool = true):Null<FlxGraphic>
		{
			if(FileSystem.exists(id)) {
				if(!Paths.currentTrackedAssets.exists(id)) {
					var newBitmap:BitmapData = BitmapData.fromFile(id);
					if (newBitmap != null){
					if (allowGPU && ClientPrefs.cacheOnGPU)
						{
							var texture:openfl.display3D.textures.RectangleTexture = FlxG.stage.context3D.createRectangleTexture(newBitmap.width, newBitmap.height, BGRA, true);
							texture.uploadFromBitmapData(newBitmap);
							newBitmap.image.data = null;
							newBitmap.dispose();
							newBitmap.disposeImage();
							newBitmap = BitmapData.fromTexture(texture);
						}
					}
					var newGraphic:FlxGraphic = FlxGraphic.fromBitmapData(newBitmap, false, id);
					newGraphic.persist = true;
			        newGraphic.destroyOnNoUse = false;
					Paths.localTrackedAssets.push(id);
					Paths.currentTrackedAssets.set(id, newGraphic);
				}
				return Paths.currentTrackedAssets.get(id);
			}
	
			return null;
		}
	public static function askToSave(id:String, data:Dynamic)
	{
		_file = new FileReference();

		_file.addEventListener(Event.COMPLETE, onSaveComplete);
		_file.addEventListener(Event.CANCEL, onSaveCancel);
		_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		var idSus = Path.withoutDirectory(id);
		_file.save(data, idSus);
	}
	static function onSaveComplete(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.notice("Successfully saved LEVEL DATA.");
	};
	static function onSaveCancel(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
	};
	static function onSaveError(_):Void
	{
		_file.removeEventListener(Event.COMPLETE, onSaveComplete);
		_file.removeEventListener(Event.CANCEL, onSaveCancel);
		_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
		_file = null;
		FlxG.log.error("Problem saving Level data");
	}
	
}
