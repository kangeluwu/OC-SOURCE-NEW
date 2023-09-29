function onCreatePost()
      luaDebugMode = true
     initLuaShader("vcr")
     initLuaShader("oldtv")
    
     makeLuaSprite("shaderImage")
     makeGraphic("shaderImage", screenWidth, screenHeight)
    
     setSpriteShader("shaderImage", "vcr")
    
     makeLuaSprite("shaderImage2")
     makeGraphic("shaderImage2", screenWidth, screenHeight)
    
     setSpriteShader("shaderImage2", "oldtv")
    
     addHaxeLibrary("ShaderFilter", "openfl.filters")
     runHaxeCode([[
         trace(ShaderFilter);
         game.camGame.setFilters([new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
         game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("shaderImage2").shader),new ShaderFilter(game.getLuaObject("shaderImage").shader)]);
         game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("shaderImage2").shader)]);
     ]])
    end
    
    function onUpdate(elapsed)
     setShaderFloat("shaderImage", "iTime", os.clock())
     setShaderFloat("shaderImage2", "iTime", os.clock())
    end