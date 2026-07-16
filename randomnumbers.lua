local cb = peripheral.find("chat_box")
local speaker = peripheral.find("speaker")
local monitor = peripheral.find("monitor")

speaker.stop()


if not cb then
    error("No Chat Box found!")
end
if not speaker then
    error("No Speaker found!")
end
if not monitor then
    error("No Monitor found!")
end

math.randomseed(os.epoch("utc"))


local vars = {}

monitor.clear()

local function generate(player, count, min, max)
    cb.sendMessageToPlayer("Generating random numbers...", player)
    monitor.setCursorPos(1, 1)

    for i = 1, count do
        vars[i] = math.random(min, max)
        monitor.write(("var%d: %d"):format(i, vars[i]))
        monitor.setCursorPos(1, i + 1)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(1) -- Chat Box has a cooldown
    end
end

while true do
    local _, username, message = os.pullEvent("chat")

    if message:lower() == "generate" then
        generate(username, 5, 1, 1000)
    end
end
