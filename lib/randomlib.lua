local random = {}

math.randomseed(os.epoch("utc"))

local vars = {}

-- Generate multiple random numbers
function random.generate(count, min, max)
    vars = {}

    for i = 1, count do
        vars[i] = math.random(min, max)
    end

    return vars
end

-- Stored values
function random.get(index)
    return vars[index]
end

function random.all()
    return vars
end

function random.clear()
    vars = {}
end

function random.count()
    return #vars
end

-- Random numbers
function random.int(min, max)
    return math.random(min, max)
end

function random.float(min, max)
    return min + math.random() * (max - min)
end

function random.percent()
    return math.random(0, 100)
end

function random.bool()
    return math.random(2) == 1
end

function random.sign()
    return math.random(2) == 1 and -1 or 1
end

-- Probability
function random.chance(percent)
    return math.random(100) <= percent
end

-- Tables
function random.pick(tbl)
    return tbl[math.random(#tbl)]
end

function random.shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

function random.pop(tbl)
    return table.remove(tbl, math.random(#tbl))
end

-- Dice
function random.d6()
    return math.random(6)
end

function random.d20()
    return math.random(20)
end

function random.d100()
    return math.random(100)
end

function random.dice(sides)
    return math.random(sides)
end

-- Coin
function random.coin()
    return math.random(2) == 1 and "Heads" or "Tails"
end

-- RGB Color
function random.color()
    return {
        r = math.random(255),
        g = math.random(255),
        b = math.random(255)
    }
end

-- Hex color
function random.hex()
    return string.format("#%06X", math.random(0, 0xFFFFFF))
end

-- Letter
function random.letter()
    return string.char(math.random(65, 90))
end

-- Character
function random.char()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local i = math.random(#chars)
    return chars:sub(i, i)
end

-- String
function random.string(length)
    local s = ""
    for i = 1, length do
        s = s .. random.char()
    end
    return s
end

-- UUID-like string
function random.id()
    return random.string(8) .. "-" .. random.string(4)
end

-- Seed
function random.seed(seed)
    math.randomseed(seed)
end

return random
