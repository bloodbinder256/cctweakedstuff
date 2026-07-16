local randomlib = {}

math.randomseed(os.epoch("utc"))

local vars = {}

function randomlib.generate(count, min, max)
    vars = {}

    for i = 1, count do
        vars[i] = math.random(min, max)
    end

    return vars
end

function randomlib.get(index)
    return vars[index]
end

function randomlib.getAll()
    return vars
end

function randomlib.clear()
    vars = {}
end

return randomlib
