Citizen.CreateThread(function()
    local draw = true
    heading = -45.0
    coords = vector3(259.875, -3059.475, 6.5)
    while true do

        if draw then
            nDebug('Drawing!')
            -- heading = ( heading + GetFrameTime() * 100 ) % 360.0
            FloatyDraw(coords, heading ,function(index)
                --DrawRect(0.5, 0.5, 1.0, 1.0, 100, 100, 100, 255)
                --DrawRect(0.5, 0.5, 0.9, 0.9, 0, 0, 0, 255)
                BeginTextCommandDisplayText('STRING')
                SetTextWrap(0.1, 0.9)
                SetTextCentre()
                SetTextOutline()
                SetTextJustification(0)
                SetTextScale(0.6,0.6)
                AddTextComponentSubstringPlayerName('SECRET HIDEOUT!~n~DO NOT ENTER!')
                SetTextColour(255, 255, 255, 255)
                EndTextCommandDisplayText(0.5, 0.2)
            end)
        end

        if IsControlJustPressed(0, 29) then -- INPUT_SPECIAL_ABILITY_SECONDARY, B
            draw = not draw
        end

        Citizen.Wait(0)
    end
end)