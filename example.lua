Citizen.CreateThread(function()
    local heading = 0.0
    local coords = vector3(440.801, -980.782, 30.885)
    AddTextEntry('COPS_ONLINE_WAIT', '~a~ police officers on duty.~n~Take a number and wait.')
    while true do
        local error = exports.floatydraw:FloatyDraw(coords, heading ,function(index)
            BeginTextCommandDisplayText('COPS_ONLINE_WAIT')
            SetTextFont(4)
            SetTextCentre()
            SetTextOutline()
            SetTextJustification(0)
            SetTextScale(0.9,0.9)
            AddTextComponentSubstringPlayerName('18')
            SetTextColour(100, 100, 255, 255)
            EndTextCommandDisplayText(0.5, 0.3)
        end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    local computerRT = RenderTarget(`prop_monitor_w_large`, 'tvscreen')
    AddTextEntry('COPS_ALERT', '187 in progress!')
    while true do
        computerRT(function()
            BeginTextCommandDisplayText('COPS_ALERT')
            SetTextCentre()
            SetTextJustification(0)
            SetTextColour(255, 0, 0, 255)
            EndTextCommandDisplayText(0.5, 0.3)
        end)
        Citizen.Wait(0)
    end
end)
