-- Created by RamenDominoes (Feel free to credit or not I don't really care)
--Not bad for my first event created... I think

StartStop = 0

Speed = 0



function onCreate()
	
	addHaxeLibrary('Std');
	--THE TOP BAR
	makeLuaSprite('UpperBar', 'empty', 0, -120)
	makeGraphic('UpperBar', 1280, 120, '000000')
	
	setObjectCamera('UpperBar', 'hud')
	addLuaSprite('UpperBar', true)


	--THE BOTTOM BAR
	makeLuaSprite('LowerBar', 'empty', 0, 720)
	makeGraphic('LowerBar', 1280, 120, '000000')
	setObjectCamera('LowerBar', 'hud')
	addLuaSprite('LowerBar', true)
	runHaxeCode([[

	]])
end


function onUpdate(elapsed)

	if StartStop == 1 then
	
	doTweenY('Cinematics1', 'UpperBar', 0, Speed, 'Linear')
	doTweenY('Cinematics2', 'LowerBar', 600, Speed, 'Linear')
	noteTweenY('NOTEMOVE1', 0, 130, Speed, 'Linear')	
	noteTweenY('NOTEMOVE2', 1, 130, Speed, 'Linear')
	noteTweenY('NOTEMOVE3', 2, 130, Speed, 'Linear')
	noteTweenY('NOTEMOVE4', 3, 130, Speed, 'Linear')
	noteTweenY('NOTEMOVE5', 4, 130, Speed, 'Linear')
	noteTweenY('NOTEMOVE6', 5, 130, Speed, 'Linear')
	noteTweenY('NOTEMOVE7', 6, 130, Speed, 'Linear')
	noteTweenY('NOTEMOVE8', 7, 130, Speed, 'Linear')
	doTweenAlpha('AlphaTween3', 'scoreTxt', 0, 0.1)
	doTweenAlpha('AlphaTween6', 'timeBar', 0, 0.1)
	doTweenY('lifeTween6', 'healthBar', 670, 0.1)
	doTweenY('lifeTween8', 'iconP2', 670 - 75, 0.1)
	doTweenY('lifeTween9', 'iconP1', 670 - 75, 0.1)
	doTweenAlpha('AlphaTween8', 'timeTxt', 0, 0.1)
	doTweenAlpha('AlphaTween9', 'iconP2', 0, 0.1)
	doTweenAlpha('AlphaTween10', 'iconP1', 0, 0.1)
	doTweenAlpha('AlphaTween12', 'healthBar', 0, 0.1)
	end

	if StartStop == 2 and setProperty('scoreTxt.alpha', 0) then
	
	doTweenY('Cinematics1', 'UpperBar', -120, Speed, 'Linear')
	doTweenY('Cinematics2', 'LowerBar', 720, Speed, 'Linear')
	noteTweenY('NOTEMOVE1', 0, 50, Speed, 'Linear')	
	noteTweenY('NOTEMOVE2', 1, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE3', 2, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE4', 3, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE5', 4, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE6', 5, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE7', 6, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE8', 7, 50, Speed, 'Linear')
	doTweenY('lifeTween19', 'healthBar', 640, 0.1)
	doTweenY('lifeTween8', 'iconP2', 640 - 75, 0.1)
	doTweenY('lifeTween9', 'iconP1', 640 - 75, 0.1)
	doTweenAlpha('AlphaTween6', 'timeBar', 1, 0.1)
	doTweenAlpha('AlphaTween8', 'timeTxt', 1, 0.1)
	doTweenAlpha('AlphaTween9', 'iconP2', 1, 0.1)
	doTweenAlpha('AlphaTween10', 'iconP1', 1, 0.1)
	doTweenAlpha('AlphaTween12', 'healthBar', 1, 0.1)
	end

	if downscroll and StartStop == 1 then
	
	doTweenY('Cinematics1', 'UpperBar', 0, Speed, 'Linear')
	doTweenY('Cinematics2', 'LowerBar', 600, Speed, 'Linear')
	noteTweenY('NOTEMOVE1', 0, 480, Speed, 'Linear')	
	noteTweenY('NOTEMOVE2', 1, 480, Speed, 'Linear')
	noteTweenY('NOTEMOVE3', 2, 480, Speed, 'Linear')
	noteTweenY('NOTEMOVE4', 3, 480, Speed, 'Linear')
	noteTweenY('NOTEMOVE5', 4, 480, Speed, 'Linear')
	noteTweenY('NOTEMOVE6', 5, 480, Speed, 'Linear')
	noteTweenY('NOTEMOVE7', 6, 480, Speed, 'Linear')
	noteTweenY('NOTEMOVE8', 7, 480, Speed, 'Linear')
	doTweenAlpha('AlphaTween2', 'healthBar', 0, 0.1)
	doTweenAlpha('AlphaTween3', 'scoreTxt', 0, 0.1)
	doTweenAlpha('AlphaTween4', 'iconP1', 0, 0.1)
	doTweenAlpha('AlphaTween5', 'iconP2', 0, 0.1)
	doTweenAlpha('AlphaTween6', 'timeBar', 0, 0.1)
	doTweenAlpha('AlphaTween8', 'timeTxt', 0, 0.1)
	doTweenAlpha('AlphaTween9', 'iconP2', 0, 0.1)
	doTweenAlpha('AlphaTween10', 'iconP1', 0, 0.1)

	doTweenAlpha('AlphaTween12', 'healthBar', 0, 0.1)
	end


	if StartStop == 2 then
	
	doTweenY('Cinematics1', 'UpperBar', -120, Speed, 'Linear')
	doTweenY('Cinematics2', 'LowerBar', 720, Speed, 'Linear')
	noteTweenY('NOTEMOVE1', 0, 50, Speed, 'Linear')	
	noteTweenY('NOTEMOVE2', 1, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE3', 2, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE4', 3, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE5', 4, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE6', 5, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE7', 6, 50, Speed, 'Linear')
	noteTweenY('NOTEMOVE8', 7, 50, Speed, 'Linear')
	doTweenY('lifeTween19', 'healthBar', 640, 0.1)
	doTweenY('lifeTween8', 'iconP2', 640 - 75, 0.1)
	doTweenY('lifeTween9', 'iconP1', 640 - 75, 0.1)
	doTweenAlpha('AlphaTween3', 'scoreTxt', 1, 0.1)
	doTweenAlpha('AlphaTween6', 'timeBar', 1, 0.1)
	doTweenAlpha('AlphaTween8', 'timeTxt', 1, 0.1)
	doTweenAlpha('AlphaTween9', 'iconP2', 1, 0.1)
	doTweenAlpha('AlphaTween10', 'iconP1', 1, 0.1)
	doTweenAlpha('AlphaTween12', 'healthBar', 1, 0.1)
	end

	if downscroll and StartStop == 2 then
	
	doTweenY('Cinematics1', 'UpperBar', -120, Speed, 'Linear')
	doTweenY('Cinematics2', 'LowerBar', 720, Speed, 'Linear')
	noteTweenY('NOTEMOVE1', 0, 570, Speed, 'Linear')	
	noteTweenY('NOTEMOVE2', 1, 570, Speed, 'Linear')
	noteTweenY('NOTEMOVE3', 2, 570, Speed, 'Linear')
	noteTweenY('NOTEMOVE4', 3, 570, Speed, 'Linear')
	noteTweenY('NOTEMOVE5', 4, 570, Speed, 'Linear')
	noteTweenY('NOTEMOVE6', 5, 570, Speed, 'Linear')
	noteTweenY('NOTEMOVE7', 6, 570, Speed, 'Linear')
	noteTweenY('NOTEMOVE8', 7, 570, Speed, 'Linear')
	doTweenAlpha('AlphaTween2', 'healthBar', 1, 0.1)
	doTweenAlpha('AlphaTween3', 'scoreTxt', 1, 0.1)
	doTweenAlpha('AlphaTween4', 'iconP1', 1, 0.1)
	doTweenAlpha('AlphaTween5', 'iconP2', 1, 0.1)
	doTweenAlpha('AlphaTween6', 'timeBar', 1, 0.1)
	doTweenAlpha('AlphaTween8', 'timeTxt', 1, 0.1)
	
	end
	
end

function onEvent(name,value1,value2,value3)
	if name == 'Cinematics' then
		StartStop = tonumber(value1)
		Speed = tonumber(value2)
			end
	
		end
