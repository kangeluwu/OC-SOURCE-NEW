--Example SMT modchart by TheZoroForce240
function onCreate()
    addLuaScript('SimpleModchartTemplate')
end


local scrollSwitch = 520 --height to move to when reverse

function lerp(a, b, ratio)
	return a + ratio * (b - a)
end
function onSongStart()--for step 0
    setProperty('drunk.x', 0.5)
    setProperty('drunkSpeed.x', 250)

    if downscroll then 
		scrollSwitch = -520
	end
end

local thing = 0

function onStepHit()

    if curStep == 6 or curStep == 18 or curStep == 40 or curStep == 50 or curStep == 72 or curStep == 104 or curStep == 114 then --starting section with the vibrating notes
        doTweenX('a', 'drunkSpeed', 2, stepCrochet/1000, 'elasticInOut')
        doTweenY('a1', 'drunkSpeed', 0, stepCrochet/1000, 'elasticInOut')
        doTweenAngle('a2', 'drunkSpeed', 0, stepCrochet/1000, 'elasticInOut')
    elseif curStep == 12 or curStep == 20 or curStep == 44 or curStep == 52 or curStep == 91 or curStep == 109 or curStep == 44 or curStep == 83 then 
        doTweenX('a', 'drunkSpeed', 250, stepCrochet/1000, 'elasticInOut')
    elseif curStep == 28 or curStep == 59 or curStep == 76 or curStep == 83 or curStep == 117 then 
        doTweenY('c', 'drunk', 1, stepCrochet/1000, 'elasticInOut')
        doTweenY('f', 'drunkSpeed', 250, stepCrochet/1000, 'elasticInOut')
    elseif curStep == 33 or curStep == 69 or curStep == 96 or curStep == 123 then 
        doTweenAngle('ww', 'drunk', 1, stepCrochet/1000, 'elasticInOut')
        doTweenAngle('eds', 'drunkSpeed', 250, stepCrochet/1000, 'elasticInOut')

    elseif curStep == 128 then 
        doTweenX('ae', 'drunkSpeed', 0, stepCrochet/1000, 'elasticInOut')
        doTweenY('a1e', 'drunkSpeed', 0, stepCrochet/1000, 'elasticInOut')
        doTweenAngle('a2e', 'drunkSpeed', 0, stepCrochet/1000, 'elasticInOut')
        doTweenX('aae', 'drunk', 0, stepCrochet/1000, 'elasticInOut')
        doTweenY('a1ae', 'drunk', 0, stepCrochet/1000, 'elasticInOut')
        doTweenAngle('a2ae', 'drunk', 0, stepCrochet/1000, 'elasticInOut')


    elseif curStep == 896 then
        
        triggerEvent('resetX', stepCrochet/500, 'quadInOut') --reset after done with inverts/flips
    end

    

    if curStep >= 128 and curStep <= 512 then --first section

    
        if curStep % 64 == 60 or curStep % 64 == 63 then 
            doTweenY('a', 'tipsy', 2, stepCrochet/1000, 'cubeInOut')
        elseif curStep % 64 == 61 or curStep % 64 == 63 then 
            doTweenY('a', 'tipsy', -2, stepCrochet/1000, 'cubeInOut')
        elseif curStep % 64 == 0 then 
            doTweenY('a', 'tipsy', 0, stepCrochet/1000, 'cubeInOut')
        end

        if curStep % 64 == 0 or curStep % 64 == 12 or curStep % 64 == 20 or curStep % 64 == 32 or curStep % 64 == 44 or curStep % 64 == 52 then 
            setProperty('drunk.angle', 4)
            setProperty('drunkSpeed.angle', 6)
            doTweenAngle('t', 'drunk', 0, stepCrochet/250, 'quantInOut')
        end
        if curStep >= 256 and curStep <= 500 then 
            if curStep % 16 == 8 then --clap
                for i = 0,7 do 
                    setProperty('confusion.angle', 420)
                    doTweenAngle(i, 'confusion', 0, stepCrochet/1000, 'quantInOut')
                end

                setProperty('drunk.y', 4)
                setProperty('drunkSpeed.y', 6)
                doTweenY('y', 'drunk', 0, stepCrochet/1000, 'quantInOut')
                
                if getProperty('reverse.y') == 0 then 
                    doTweenY('rev', 'reverse', 1, stepCrochet/1000, 'quantInOut')
                else 
                    doTweenY('rev', 'reverse', 0, stepCrochet/1000, 'quantInOut')
                end
            end
        end

        if curStep > 502 then 
            --doTweenY('rev', 'reverse', getProperty('reverse.y')-0.1, stepCrochet/1000, 'quantInOut')
            if getProperty('reverse.y') > 0 then 
                setProperty('reverse.y', getProperty('reverse.y')-0.1)
            end
        end

        if (curStep >= 240 and curStep < 244) or (curStep >= 368 and curStep < 372) then 
            if curStep % 4==0 then 
                setProperty('scale.x', 2)
                doTweenX('scalex', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            elseif curStep %4 == 2 then 
                setProperty('scale.y', 2)
                doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            end
        end
    elseif curStep >= 512 and curStep <= 1152 then  --when inst changes
        if curStep <= 896 or curStep >= 1136 then
            if curStep % 64 == 60 or curStep % 64 == 63 then 
                doTweenY('a', 'tipsy', 2, stepCrochet/1000, 'cubeInOut')
            elseif curStep % 64 == 61 or curStep % 64 == 63 then 
                doTweenY('a', 'tipsy', -2, stepCrochet/1000, 'cubeInOut')
            elseif curStep % 64 == 0 then 
                doTweenY('a', 'tipsy', 0, stepCrochet/1000, 'cubeInOut')
            end
        end


        if curStep % 128 <= 96 then 
            if curStep %2 == 0 then 
                
                if thing % 8 >= 4 then 
                    doTweenAngle((thing%4)..'a', 'strumOffset'..(thing%4), -100, stepCrochet/1000, 'quantInOut')
                    doTweenAngle(((thing%4)+4)..'a', 'strumOffset'..((thing%4)+4), -100, stepCrochet/1000, 'quantInOut')
                else 
                    doTweenAngle((thing%4)..'a', 'strumOffset'..(thing%4), 100, stepCrochet/1000, 'quantInOut')
                    doTweenAngle(((thing%4)+4)..'a', 'strumOffset'..((thing%4)+4), 100, stepCrochet/1000, 'quantInOut')
                end
                thing = thing + 1
                
            end
        else 
            
            if thing % 8 >= 4 then 
                doTweenAngle((thing%4)..'a', 'strumOffset'..(thing%4), -100, stepCrochet/1000, 'quantInOut')
                doTweenAngle(((thing%4)+4)..'a', 'strumOffset'..((thing%4)+4), -100, stepCrochet/1000, 'quantInOut')
            else 
                doTweenAngle((thing%4)..'a', 'strumOffset'..(thing%4), 100, stepCrochet/1000, 'quantInOut')
                doTweenAngle(((thing%4)+4)..'a', 'strumOffset'..((thing%4)+4), 100, stepCrochet/1000, 'quantInOut')
            end
            thing = thing + 1
        end


        if curStep >= 640 and curStep <= 896 then 
            if curStep % 128 <= 112 then 
                if curStep % 32 == 8 then
                    triggerEvent('invert', stepCrochet/500, 'quadInOut')
                elseif curStep % 32 == 24 then 
                    triggerEvent('resetX', stepCrochet/500, 'quadInOut')
                elseif curStep % 32 == 14 then --lazer sounding thing
                    triggerEvent('flip', stepCrochet/500, 'quadInOut')
                end
            end
        end
    elseif curStep >= 1152 and curStep <= 1664 then --just after ascend part

        if curStep % 64 == 60 or curStep % 64 == 63 then 
            doTweenY('a', 'tipsy', 2, stepCrochet/1000, 'cubeInOut')
        elseif curStep % 64 == 61 or curStep % 64 == 63 then 
            doTweenY('a', 'tipsy', -2, stepCrochet/1000, 'cubeInOut')
        elseif curStep % 64 == 0 then 
            doTweenY('a', 'tipsy', 0, stepCrochet/1000, 'cubeInOut')
        end




        if (curStep >= 1264 and curStep < 1268) or (curStep >= 1392 and curStep < 1396) or (curStep >= 1520 and curStep < 1524) then 
            if curStep % 4==0 then 
                setProperty('scale.x', 2)
                doTweenX('scalex', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            elseif curStep %4 == 2 then 
                setProperty('scale.y', 2)
                doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
            end
        end

        if (curStep >= 1152 and curStep <= 1408) or (curStep >= 1536 and curStep <= 1664) then
            triggerEvent('resetZ', stepCrochet/500, 'quadInOut')
            if curStep % 8 == 4 then 
                setProperty('scale.y', 0.25)
                doTweenY('scaley', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
                setProperty('scale.x', 1)
                doTweenX('scalex', 'scale', 0.7, stepCrochet/500, 'cubeInOut')
                setProperty('camHUD.angle', 10)
                doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
            elseif curStep % 8 == 0 then 
                setProperty('drunk.angle', 6)
                setProperty('drunkSpeed.angle', 8)
                doTweenAngle('t', 'drunk', 0, stepCrochet/250, 'quantInOut')
                setProperty('camHUD.angle', -10)
                doTweenAngle('camHUD', 'camHUD', 0, stepCrochet/250, 'cubeInOut')
            end
        end


        if curStep >= 1408 and curStep <= 1520 then 
            setProperty('camHUD.angle', 0)
            if curStep % 16 == 8 then --clap
                for i = 0,7 do 
                    setProperty('confusion.angle', 420)
                    doTweenAngle(i, 'confusion', 0, stepCrochet/1000, 'quantInOut')
                end

                setProperty('drunk.y', 4)
                setProperty('drunkSpeed.y', 6)
                doTweenY('y', 'drunk', 0, stepCrochet/1000, 'quantInOut')
                
                if getProperty('reverse.y') == 0 then 
                    doTweenY('rev', 'reverse', 1, stepCrochet/1000, 'quantInOut')
                else 
                    doTweenY('rev', 'reverse', 0, stepCrochet/1000, 'quantInOut')
                end
            end
        end
    end


end 