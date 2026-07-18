local random = {}

-- Seed using milliseconds for better randomness
math.randomseed(os.epoch("utc"))

-- Discard the first few values
math.random()
math.random()
math.random()

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
    local copy = {}

    for i, v in ipairs(vars) do
        copy[i] = v
    end

    return copy
end

function random.reset()
    vars = {}
end

function random.number(min, max)
    return math.random(min, max)
end

return random