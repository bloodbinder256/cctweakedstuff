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

local function generate(count, min, max)
    cb.sendMessage("Generating random numbers...")

    for i = 0, count do
        vars[i] = math.random(min, max)
        cb.sendMessage(("var%d: %d"):format(i, vars[i]))
        speaker.playSound("minecraft:block.note_block.harp")
        sleep(1) -- Chat Box has a cooldown
    end
end

while true do
    local _, message = os.pullEvent("chat")

    if message:lower() == "generate" then
        generate(5, 1, 9)
        speaker.stop()
    end
end
