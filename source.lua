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
end
function util:Get(x)
    return rawget(util.services, x)
end
return util