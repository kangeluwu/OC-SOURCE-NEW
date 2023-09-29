local shadersEnabled = true
local iTime
function onCreate() 
    if shadersEnabled then  
        local var ShaderName = 'brimstoneCamEffects'
        initLuaShader(ShaderName)
        makeLuaSprite('camShader', nil)
        makeGraphic('camShader', screenWidth, screenHeight)
        setSpriteShader('camShader', ShaderName)
        

        runHaxeCode([[
            trace(game.getLuaObject('camShader').shader + ' Has Been Loaded!');                      
            FlxG.game.setFilters([new ShaderFilter(game.getLuaObject('camShader').shader)]);
        ]])

        function onUpdate(elapsed)
            --setShaderFloat('camShader', ShaderName, 114514)
        end
    end
end

function onDestroy()
    if shadersEnabled then
        runHaxeCode([[
            FlxG.game.setFilters([]);
        ]])
    end
end