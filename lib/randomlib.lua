local random = {}

local seedValue = 0

if os.epoch then
    seedValue = os.epoch("utc")
else
    seedValue = os.time("utc")
end

math.randomseed(seedValue)

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

function random.get(index) return vars[index] end

function random.getAll() return vars end

function random.reset() vars = {} end

return random
