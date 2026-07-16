local random = require("cctweakedstuff.randomlib")

local cb = peripheral.find("chat_box")
local speaker = peripheral.find("speaker")
local monitor = peripheral.find("monitor")

speaker.stop()

if not cb then error("No Chat Box found!") end
if not speaker then error("No Speaker found!") end
if not monitor then error("No Monitor found!") end

local function generate(player, count, min, max, sleepamount)
    cb.sendMessageToPlayer("Generating random numbers...", player)

    monitor.clear()
    monitor.setCursorPos(1, 1)

    local vars = random.generate(count, min, max)

    for i, value in ipairs(vars) do
        monitor.write(("var%d: %d"):format(i, value))
        monitor.setCursorPos(1, i + 1)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(sleepamount)
    end
end

while true do
    local event, arg1, arg2 = os.pullEvent()

    if event == "monitor_touch" then
        monitor.clear()
    elseif event == "chat" then
        local username, message = arg1, arg2

        if message:lower() == "generate" then
            generate(username, 5, 1, 1000, 0.5)
        end
    end
end
