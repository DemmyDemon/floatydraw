local RenderTargets = {
    {model=`xm_prop_x17_tv_scrn_01`,name='prop_x17_tv_scrn_01'},
    {model=`xm_prop_x17_tv_scrn_02`,name='prop_x17_tv_scrn_02'},
    {model=`xm_prop_x17_tv_scrn_03`,name='prop_x17_tv_scrn_03'},
    {model=`xm_prop_x17_tv_scrn_04`,name='prop_x17_tv_scrn_04'},
    {model=`xm_prop_x17_tv_scrn_05`,name='prop_x17_tv_scrn_05'},
    {model=`xm_prop_x17_tv_scrn_06`,name='prop_x17_tv_scrn_06'},
    {model=`xm_prop_x17_tv_scrn_07`,name='prop_x17_tv_scrn_07'},
    {model=`xm_prop_x17_tv_scrn_08`,name='prop_x17_tv_scrn_08'},
    {model=`xm_prop_x17_tv_scrn_09`,name='prop_x17_tv_scrn_09'},
    {model=`xm_prop_x17_tv_scrn_10`,name='prop_x17_tv_scrn_10'},
    {model=`xm_prop_x17_tv_scrn_11`,name='prop_x17_tv_scrn_11'},
    {model=`xm_prop_x17_tv_scrn_12`,name='prop_x17_tv_scrn_12'},
    {model=`xm_prop_x17_tv_scrn_13`,name='prop_x17_tv_scrn_13'},
    {model=`xm_prop_x17_tv_scrn_14`,name='prop_x17_tv_scrn_14'},
    {model=`xm_prop_x17_tv_scrn_15`,name='prop_x17_tv_scrn_15'},
    {model=`xm_prop_x17_tv_scrn_16`,name='prop_x17_tv_scrn_16'},
    {model=`xm_prop_x17_tv_scrn_17`,name='prop_x17_tv_scrn_17'},
    {model=`xm_prop_x17_tv_scrn_18`,name='prop_x17_tv_scrn_18'},
    {model=`xm_prop_x17_tv_scrn_19`,name='prop_x17_tv_scrn_19'},
}

local lastDraw = 0
local testRadius = 2.0
local index = 1

function FloatyDraw(coords, heading, callback)

    local testCoords = coords + vector3(0,0,0.5)

    if not IsSphereVisible(testCoords, testRadius) then
        -- Not visible on screen, not attempting draw at all
        return 'Not on screen'
    end

    local camCoord = GetFinalRenderedCamCoord()
    local distance = #( camCoord - coords )
    if distance > 100 then
        -- Not drawing:  Target coordinates are further than the prop LOD dist!
        return 'Point out of range'
    end

    local diff = (testCoords - camCoord)
    local diffAngle = math.deg(math.atan(diff.y, diff.x))
    local compare = diffAngle - heading
    if compare < 0 and compare > -180 then
        return 'Not a visible angle'
    end

    local now = GetGameTimer()
    if lastDraw == now then
        index = index + 1
    else
        index = 1
    end

    if RenderTargets[index] then
        lastDraw = now
        
        local RT = RenderTargets[index]

        if not RT.rt then
            RT.rt = RenderTarget(RT.model, RT.name)
        end

        if not RT.entity or not DoesEntityExist(RT.entity) then
            RT.entity = CreateObjectNoOffset(RT.model, coords, false, false, false)
            SetEntityAsMissionEntity(RT.entity, true, true) -- Do not cull, plx!
            SetEntityCollision(RT.entity, false, false)
            SetEntityAlpha(RT.entity, 254) -- Makes the background completely transparent!
        end

        SetEntityCoordsNoOffset(RT.entity, coords, false, false, false)
        SetEntityHeading(RT.entity, heading)

        local error = RT.rt(function()
            callback(RT.entity, distance)
        end)

        if error then
            print('FloatyDraw failed callback: ' .. message)
            Citizen.Wait(1000)
            return 'Failed callback: ' .. message
        end

    else
        print('FloatyDraw ran out of draw targets! Can only do 19 at a time!')
        Citizen.Wait(1000)
        return 'Too many targets!'
    end

end
exports('FloatyDraw', FloatyDraw)

AddEventHandler('onResourceStop',function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for i, target in pairs(RenderTargets) do
            if target.rt then
                target.rt:release()
            end
            if target.entity and DoesEntityExist(target.entity) then
                DeleteEntity(target.entity)
            end
        end
    end
end)
