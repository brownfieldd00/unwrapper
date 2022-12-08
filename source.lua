util = {}
util.functions = {}

util.empty = function()
    return {}
end
function util:get(url)
    return game:HttpGet(url)
end
function util:loadUiLibrary()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/brownfieldd00/ui-engine-v2/main/library.lua"))()--
end
function util.getVar(x)
    return getfenv()[x] or util.empty
end
function util:getVariable(a)
    return util.getVar(a)
end
function util:registerFunction(name, callback)
    util.functions[name] = callback
    return true, util.functions[name]
end
return util