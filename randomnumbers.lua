package.path = package.path .. ";/lib/?.lua"

local random = require("lib/randomlib")

local speaker = peripheral.find("speaker")
local monitor = peripheral.find("monitor")
local relay = peripheral.find("redstone_relay")

if not speaker then error("No Speaker found!") end
if not monitor then error("No Monitor found!") end
if not relay then error("No Redstone Relay found!") end

speaker.stop()


local numberCount = 1


local function updateMonitor()
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Amount: " .. numberCount)
end


local function generate()
    monitor.clear()
    monitor.setCursorPos(1, 1)

    local width, height = monitor.getSize()
    local x, y = 1, 1

    local vars = random.generate(numberCount, 1, 1000)

    for i, value in ipairs(vars) do
        local text = ("var%d: %d"):format(i, value)

        -- move to next row if needed
        if y > height then
            y = 1
            monitor.clear()
        end

        monitor.setCursorPos(x, y)
        monitor.write(text)

        speaker.playSound(
            "minecraft:block.note_block.harp"
        )

        y = y + 1

        sleep(0.5)
    end
end


local function buttonWatcher()
    local lastLeft = false
    local lastRight = false
    local lastTop = false
    local lastFront = false

    while true do
        local left = relay.getInput("right")
        local right = relay.getInput("left")
        local top = relay.getInput("top")
        local front = relay.getInput("front")


        -- RIGHT BUTTON: add 1
        if right and not lastRight then
            numberCount = numberCount + 1
            updateMonitor()

            speaker.playSound(
                "minecraft:block.note_block.pling"
            )
        end


        -- LEFT BUTTON: remove 1
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
            sleep(1)
            monitor.clear()

            speaker.playSound(
                "minecraft:block.note_block.bell"
            )
        end


        -- FRONT BUTTON: generate numbers
        if front and not lastFront then
            generate("Button")
        end


        lastLeft = left
        lastRight = right
        lastTop = top
        lastFront = front


        sleep(0.1)
    end
end


updateMonitor()


parallel.waitForAny(
    buttonWatcher
)
