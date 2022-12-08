util = {}
function util:get(url)
    return game:HttpGet(url)
end
return util