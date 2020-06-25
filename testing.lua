Citizen.CreateThread(function()
    local draw = true
    local heading = 339.988
    local coords = vector3(68.363, -836.339, 32.904)
    while true do

        if draw then
            -- heading = ( heading + GetFrameTime() * 100 ) % 360.0
            FloatyDraw(coords, heading ,function(index)
                DrawRect(0.5, 0.5, 1.0, 1.0, 255, 100, 0, 255)
                DrawRect(0.5, 0.5, 0.9, 0.9, 0, 0, 0, 255)
                BeginTextCommandDisplayText('STRING')
                SetTextWrap(0.1, 1.9)
                SetTextFont(4)
                SetTextCentre()
                SetTextOutline()
                SetTextJustification(0)
                SetTextScale(1.5,1.5)
                AddTextComponentSubstringPlayerName('SECRET HIDEOUT!~n~DO NOT ENTER!')
                SetTextColour(255, 100, 0, 255)
                EndTextCommandDisplayText(0.5, 0.1)
            end)
        end

        if IsControlJustPressed(0, 29) then -- INPUT_SPECIAL_ABILITY_SECONDARY, B
            draw = not draw
        end

        Citizen.Wait(0)
    end
end)