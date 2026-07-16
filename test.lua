local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local seed1, seed2 = math.randomseed()
local seedresult = nil


seed1 = math.randomseed()
seed2 = math.randomseed()

seedresult = seed1 + seed2 * math.random(1, 1000)

v1 = math.random(seedresult)
v2 = math.random(seedresult)
v3 = math.random(seedresult)
v4 = math.random(seedresult)
v5 = math.random(seedresult)

print("Random numbers generated:")
print("v1: " .. v1)
print("v2: " .. v2)
print("v3: " .. v3)
print("v4: " .. v4)
print("v5: " .. v5)