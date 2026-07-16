local random = require("cctweakedstuff.randomlib")

math.randomseed(os.epoch("utc"))

local vars = {}

function random.generate(count, min, max)
    vars = {}

    for i = 1, count do
        vars[i] = math.random(min, max)
    end

    return vars
end

function random.get(index)
    return vars[index]
end

function random.getAll()
    return vars
end

return random
