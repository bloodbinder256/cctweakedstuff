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

    local vars = random.generate(count, min, max)

    for i, value in ipairs(vars) do
        monitor.setCursorPos(1, i)
        monitor.write(("var%d: %d"):format(i, value))

        speaker.playSound("minecraft:block.note_block.harp")

        sleep(sleepamount)
    end
end


local function relayWatcher()
    local oldState = false

    while true do
        local state = relay.getInput("front")

        if state and not oldState then
            monitor.clear()
            monitor.setCursorPos(1,1)
            monitor.write("Relay triggered!")
            speaker.playSound("minecraft:block.note_block.bell")
        end

        oldState = state

        sleep(0.1)
    end
end


local function chatWatcher()
    while true do
        local event, username, message = os.pullEvent("chat")

        if message:lower() == "generate" then
            generate(username, 5, 1, 1000, 0.5)
        end
    end
end


parallel.waitForAny(
    relayWatcher,
    chatWatcher
)