local Open = false
RegisterCommand('openSettingsMenu', function() -- Fixed typo in the command name. (openSettinggmenu -> openSettingsMenu)
  OpenPauseMenu()
end)

-- Pretty sure this can be done in a single thread. Neither of them are crazy resource intesnive.
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DisableControlAction(0, 0x4A903C11) -- Per the docs doesn't return anything. https://vespura.com/doc/natives/?_0xFE99B66D079CF6BC
    if IsDisabledControlJustPressed(0, 0x4A903C11) then
      OpenPauseMenu()
    end
  end
end)

-- This native returns true if the pause menu is active, false if it isn't. I'm not sure why you're using a loop to check this, or rather set it. https://vespura.com/doc/natives/?_0x535384D6067BA42E
 CreateThread(function()
   while true do
     IsPauseMenuActive(true)
     Wait(1)
   end
 end)

--Added the CB to let JS know that the request was received. Otherwise it can show timeouts in your F8 console.
RegisterNUICallback('exit', function(data, cb)
  ClosePauseMenu()
  cb('ok')
end)

RegisterNUICallback('SendAction', function(data, cb)
  cb('ok')
  if data.action == 'settings' then
    LaunchUiAppByHash(`settings_menu`)
  elseif data.action == 'exit' then
    TriggerServerEvent("pausemenu:quit")
    ClosePauseMenu()
  elseif data.action == 'map' then
    LaunchUiAppByHash(`map`)
    ClosePauseMenu()
  end
end)

-- Extracted this method since it was being used right after declaration inside fo the above callback.
function LaunchUiAppByHash(hash)
  Citizen.InvokeNative(0xC8FC7F4E4CF4F581, hash)
  ClosePauseMenu()
end

-- Moved down to logically group it with the close method.
function OpenPauseMenu()
  Wait(200)
  if not Open and not IsPauseMenuActive() then
    SetNuiFocus(true, true)
    SendNUIMessage({
      action = 'show',
    })
    Open = true
  end
end

-- Extracted this bit of repeated code into a function.
function ClosePauseMenu()
  SetNuiFocus(false, false)
  Open = false
end