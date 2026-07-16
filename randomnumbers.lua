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


local numberCount = 1


local function updateMonitor()
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Numbers: " .. numberCount)
end


local function generate(player)
    cb.sendMessageToPlayer(
        "Generating " .. numberCount .. " random numbers...",
        player
    )

    monitor.clear()

    local vars = random.generate(numberCount, 1, 1000)

    for i, value in ipairs(vars) do
        monitor.setCursorPos(1, i)
        monitor.write(("var%d: %d"):format(i, value))

        speaker.playSound("minecraft:block.note_block.harp")

        sleep(0.5)
    end
end


local function buttonWatcher()
    local lastLeft = false
    local lastRight = false
    local lastTop = false

    while true do
        local left = relay.getInput("left")
        local right = relay.getInput("right")
        local top = relay.getInput("top")


        -- RIGHT BUTTON: add 1 number
        if right and not lastRight then
            numberCount = numberCount + 1

            updateMonitor()

            speaker.playSound(
                "minecraft:block.note_block.pling"
            )
        end


        -- LEFT BUTTON: remove 1 number
        if left and not lastLeft then
            numberCount = math.max(1, numberCount - 1)

            updateMonitor()

            speaker.playSound(
                "minecraft:block.note_block.bass"
            )
        end


        -- TOP BUTTON: reset screen
        if top and not lastTop then
            monitor.clear()
            monitor.setCursorPos(1, 1)
            monitor.write("Screen Reset")

            speaker.playSound(
                "minecraft:block.note_block.bell"
            )
        end


        lastLeft = left
        lastRight = right
        lastTop = top


        sleep(0.1)
    end
end


local function chatWatcher()
    while true do
        local event, username, message = os.pullEvent("chat")

        if message:lower() == "generate" then
            generate(username)
        end
    end
end


updateMonitor()


parallel.waitForAny(
    buttonWatcher,
    chatWatcher
)
