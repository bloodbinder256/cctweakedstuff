package.path = package.path .. ";/lib/?.lua"

local random = require("lib/randomlib")

local cb = peripheral.find("chat_box")
local speaker = peripheral.find("speaker")
local monitor = peripheral.find("monitor")
local relay = peripheral.find("redstone_relay")

if not cb then error("No Chat Box found!") end
if not speaker then error("No Speaker found!") end
if not monitor then error("No Monitor found!") end
if not relay then error("No Redstone Relay found!") end

speaker.stop()

local function generate(player, count, min, max, sleepamount)
    cb.sendMessageToPlayer("Generating random numbers...", player)

    monitor.clear()
    monitor.setCursorPos(1, 1)

    local vars = random.generate(count, min, max)

    for i, value in ipairs(vars) do
        monitor.setCursorPos(1, i)
        monitor.write(("var%d: %d"):format(i, value))

        speaker.playSound("minecraft:block.note_block.harp")

        sleep(sleepamount)
    end
end


local lastRelayInput = false

while true do
    -- Check relay front input
    local relayInput = relay.getInput("front")

    -- Runs once when the relay turns ON
    if relayInput and not lastRelayInput then
        monitor.clear()
        monitor.setCursorPos(1, 1)
        monitor.write("Relay activated!")
        
        speaker.playSound("minecraft:block.note_block.bell")
    end

    lastRelayInput = relayInput


    -- Check chat messages
    local event, arg1, arg2 = os.pullEvent()

    if event == "chat" then
        local username = arg1
        local message = arg2

        if message:lower() == "generate" then
            generate(username, 5, 1, 1000, 0.5)
        end
    end
end