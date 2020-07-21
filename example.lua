AddTextEntry('COPS_ONLINE_WAIT', '18 police officers on duty.~n~Take a number and wait.')
AddTextEntry('NO_SMOKING', 'NO SMOKING!')
AddTextEntry('NO_HORSES', 'TAKE THE HORSE~n~OUTSIDE!')
AddTextEntry('EVIL_CAMERA', 'No waving~n~at camera!')
AddTextEntry('BOSS_STATUS', 'Boss is~n~~r~OUT!')

function DrawSignText(label, r, g, b)
    BeginTextCommandDisplayText(label)
    SetTextFont(4)
    SetTextCentre()
    SetTextOutline()
    SetTextJustification(0)
    SetTextScale(0.9,0.9)
    SetTextColour(r, g, b, 255)
    EndTextCommandDisplayText(0.5, 0.3)
end

local TestSigns = {
    {coords = vector3(440.801, -980.782, 30.885), heading = 0.0,   label = 'COPS_ONLINE_WAIT',  r=100, g=100, b=255},
    {coords = vector3(437.599, -988.318, 31.007), heading = 180.0, label = 'NO_HORSES',         r=255, g=255, b=0},
    {coords = vector3(441.124, -988.318, 31.007), heading = 180.0, label = 'NO_SMOKING',        r=255, g=0,   b=0},
    {coords = vector3(441.372, -988.308, 32.086), heading = 180.0, label = 'EVIL_CAMERA',      r=255, g=0,   b=255},
    {coords = vector3(447.206, -980.080, 30.904), heading = 0.0,   label = 'BOSS_STATUS',       r=255, g=255, b=255},
}

Citizen.CreateThread(function()
    while true do
        for _, sign in ipairs(TestSigns) do
            local error = exports.floatydraw:FloatyDraw(sign.coords, sign.heading ,function(index)
                DrawSignText(sign.label, sign.r, sign.g, sign.b)
            end)
        end
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
