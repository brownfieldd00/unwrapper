util = {}
util.functions = {}
util.services = {}
util.empty = function()
    return {}
end
util.zero = 0
function util:get(url)
    return game:HttpGet(url)
end
function util:loadUiLibrary()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/brownfieldd00/ui-engine-v2/main/library.lua"))()--
end
function util:getVariable(a)
    return getfenv()[a] or util.empty
end
function util:registerFunction(name, callback)
    util.functions[name] = callback
    return true, util.functions[name]
end
function util:getCallback(callback)
    return {callback()}
end
function util:getF(a)
    return util.functions[a]
end
function util:GetServices()
    util.services = {}
    local _ = game:GetService('ReplicatedStorage')
    for i, v in pairs(game:GetChildren()) do
        local success, ret = pcall(function()
            local _ = game:GetService(v.Name)
            return _
        end)
        if success then
            util.services[v.Name] = ret
        end
    end
    return util.services
end
function util:Get(x)
    return rawget(util.services, x)
end
function util:InitFunctions()
    return util.functions
end
function util:executeNow(func, ...)
    local success, ret = pcall(function(...)
        return func(...)
    end)
    if success then
        return true, ret
    else
        return false, {}
    end
end
function util:loadModuleFromGC(ressemblances)
    ressemblances = {
        'Get', 'Fetch'
    }
    local gc = getgc(true)
    local Module;
    for i, v in pairs(gc) do
        if type(v) == 'table' then
            local module = v
            local amountMatched = 0
            for i, v in pairs(ressemblances) do
                for x, y in pairs(module) do
                    if v == x then
                        amountMatched = amountMatched + 1
                    end
                end
            end
            if amountMatched == #ressemblances then
                Module = module
                return module
            end
        end
    end
    return Module or {}
end
function util:tween(obj, prop, duration)
    local duration = duration or 2
    local TweenService = game:GetService('TweenService')
    local Tween = TweenService:Create(obj, TweenInfo.new(duration), prop)
    Tween:Play()
    return Tween
end
util:GetServices()
return util