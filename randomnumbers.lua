local cb = peripheral.find("chat_box")
local speaker = peripheral.find("speaker")
if not cb then
    error("No Chat Box found!")
end
if not speaker then
    error("No Speaker found!")
end

math.randomseed(os.epoch("utc"))

local vars = {}

local function generate(player, count, min, max)
    cb.sendMessageToPlayer("Generating random numbers...", player)

    for i = 0, count do
        vars[i] = math.random(min, max)
        cb.sendMessageToPlayer(("var%d: %d"):format(i, vars[i]), player)
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(1) -- Chat Box has a cooldown
    end
    speaker.playSound("minecraft:block.note_block.cow_bell")
end

while true do
    local _, username, message = os.pullEvent("chat")

    if message:lower() == "generate" then
        generate(username, 5, 1, 1000)
        speaker.stop()
    end
end
