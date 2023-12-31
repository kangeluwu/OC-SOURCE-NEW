-- Help from Pinacolada
-- This probably wont work on any other ersion besides 0.6.3!!!

function onCreatePost()
    initLuaShader("Bloom");
    makeLuaSprite("Bloom") makeGraphic("Bloom", screenWidth, screenHeight);
    setSpriteShader("Bloom", "Bloom");

   --setShaderFloatArray('Bloom', 'u_samples', {12, 20}); -- (8.0, 8.0) means it calculates 64 samples per pixel, per frame... Obviously if your FPS went down youre gona decrease this value, the first is how many copies will be displayed acording to the u_size value, the second is how many copies will be displayed among the first section of copies.
   --setShaderFloatArray('Bloom', 'u_size', {50, 50}); -- Size of bloom for each axis in pixels(Its like X and Y), the higher the val the more u_samples you will need to make the effect smooth. Has no impact on performance, only u_samples does.
   --setShaderFloatArray('Bloom', 'u_tint', {124, 15, 10}); -- Bloom color multipliyer(RGB)

   setShaderFloatArray('Bloom', 'u_samples', {12, 20}); -- (8.0, 8.0) means it calculates 64 samples per pixel, per frame... Obviously if your FPS went down youre gona decrease this value, the first is how many copies will be displayed acording to the u_size value, the second is how many copies will be displayed among the first section of copies.
   setShaderFloatArray('Bloom', 'u_size', {50, 50}); -- Size of bloom for each axis in pixels(Its like X and Y), the higher the val the more u_samples you will need to make the effect smooth. Has no impact on performance, only u_samples does.
   setShaderFloatArray('Bloom', 'u_tint', {200, 0, 0}); -- Bloom color multipliyer(RGB)

   setShaderFloat('Bloom', 'u_brightness', 0); -- Disables calculating samples when 0 for performance
   --setShaderFloat('Bloom', 'u_brightness', 0.01); -- Disables calculating samples when 0 for performance
    setShaderFloat('Bloom', 'u_range', 0.05); -- Softness of the threshold on either side of it. Minimum 0!!
    setShaderFloat('Bloom', 'u_threshold', 0.05); -- Luminance threshold / cutoff for bloom. 0 to 1 range!!

    addHaxeLibrary("ShaderFilter", "openfl.filters");

    runHaxeCode([[trace(ShaderFilter);
        pushCameraShader('',new ShaderFilter(game.getLuaObject("Bloom").shader));
    ]]); -- Remove the → // ←  above if you want the shader on the pause screen
    setShaderFloat('Bloom', 'u_brightness', 0.005);
end
function onBeatHit()
 
end