local Open = false
local ConfirmQuit = false -- Tracks whether the user has confirmed quitting

RegisterCommand('openSettingsMenu', function()
  OpenPauseMenu()
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    DisableControlAction(0, 0x4A903C11) -- Disable default pause menu behavior
    if IsDisabledControlJustPressed(0, 0x4A903C11) then
      OpenPauseMenu()
    end
  end
end)

-- Callback for exiting the menu (resume button)
RegisterNUICallback('exit', function(data, cb)
  ClosePauseMenu()
  cb('ok')
end)

-- Callback for handling menu actions
RegisterNUICallback('SendAction', function(data, cb)
  cb('ok')
  if data.action == 'settings' then
    LaunchUiAppByHash(`settings_menu`)
  elseif data.action == 'exit' then
    -- Show quit confirmation dialog instead of quitting immediately
    SendNUIMessage({
      action = 'showQuitConfirmation',
    })
  elseif data.action == 'map' then
    LaunchUiAppByHash(`map`)
    ClosePauseMenu()
  end
end)

-- Callback for confirming quit action
RegisterNUICallback('confirmQuit', function(data, cb)
  if data.confirm then
    TriggerServerEvent("pausemenu:quit")
    ClosePauseMenu()
  else
    -- If the user cancels, just close the confirmation dialog
    SendNUIMessage({
      action = 'hideQuitConfirmation',
    })
  end
  cb('ok')
end)

function LaunchUiAppByHash(hash)
  Citizen.InvokeNative(0xC8FC7F4E4CF4F581, hash)
  ClosePauseMenu()
end

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

function ClosePauseMenu()
  SetNuiFocus(false, false)
  SendNUIMessage({
    action = 'hide',
  })
  Open = false
end
