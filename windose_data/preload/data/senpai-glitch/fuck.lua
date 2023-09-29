
function onCreate()

  setProperty('healthBar.alpha',  0);
  setProperty('iconP1.alpha', 0);
  setProperty('iconP2.alpha', 0);
  setProperty('scoreTxt.alpha', 0);
end
function onCreatePost()

end
function onUpdate(elapsed)

end

function onStartCountdown()

  setProperty('healthBar.alpha',  1);
  setProperty('iconP1.alpha', 1);
  setProperty('iconP2.alpha', 1);
  setProperty('scoreTxt.alpha', 1);
  return Function_Continue;
end