local RTMeta = {
    __call = function(instance, callback)

        if not instance._properties.handle then
            instance:attach()
        end

        if instance._properties.handle then
            SetTextRenderId(instance._properties.handle)
            SetScriptGfxDrawOrder(instance._properties.drawOrder)
            local success, message = pcall(callback)
            if not success then
                return message
            end
            SetTextRenderId(1)
        else
            return 'Render target handle unavailable. Drawing after :release?'
        end

    end,
    release = function(instance)
        ReleaseNamedRendertarget(instance._properties.targetName)
        instance._properties.handle = nil
    end,
    attach = function(instance)
        if not instance._properties.handle then
            if not IsNamedRendertargetRegistered(instance._properties.targetName) and not IsNamedRendertargetLinked(instance._properties.model) then
                RegisterNamedRendertarget(instance._properties.targetName, false)
                LinkNamedRendertarget(instance._properties.model)
            end
            instance._properties.handle = GetNamedRendertargetRenderId(instance._properties.targetName)
        end
        return instance._properties.handle
    end,
}

function RenderTarget(model, targetName, drawOrder)

    if type(model) == 'string' then
        model = GetHashKey(model)
    end

    assert(IsModelValid(model),'RenderTarget requires a valid model as it\'s first argument!')
    assert(type(targetName) == 'string', 'RenderTarget requires a string for it\'s second argument, targetName!')

    drawOrder = drawOrder or 4
    assert(type(drawOrder) == 'number', 'RenderTarget requires a number for it\'s third argument. drawOrder is usually 4 and can be left out.')

    --[[
    if not IsNamedRendertargetRegistered(targetName) and not IsNamedRendertargetLinked(model) then
        RegisterNamedRendertarget(targetName, false)
        LinkNamedRendertarget(model)
    end

    local handle = GetNamedRendertargetRenderId(targetName)
    --]]

    local RT = {
        _properties = {
            model = model,
            targetName = targetName,
            drawOrder = drawOrder,
        }
    }

    setmetatable(RT, RTMeta)
    RT:attach()
    return RT
end