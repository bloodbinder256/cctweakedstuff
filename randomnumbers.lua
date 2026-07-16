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

    local width, height = monitor.getSize()

    local vars = random.generate(numberCount, 1, 1000)

    local columnWidth = 15

    local columns = math.floor(width / columnWidth)

    if columns < 1 then
        monitor.setCursorPos(1, 1)
        monitor.write("Monitor too small")
        return
    end


    local row = 1
    local column = 0


    for i, value in ipairs(vars) do
        local text = ("var%d: %d"):format(i, value)

        local x = (column * columnWidth) + 1


        -- move to next column if text doesn't fit
        if x + #text - 1 > width then
            column = column + 1
            row = 1
            x = (column * columnWidth) + 1
        end


        -- stop if the column is off the monitor
        if x + #text - 1 > width then
            monitor.clear()

            row = 1
            column = 0

            x = 1

            monitor.setCursorPos(x, row)
            monitor.write(text)

            row = row + 1
        end


        monitor.setCursorPos(x, row)
        monitor.write(text)


        row = row + 1


        -- move down the column
        if row > height then
            row = 1
            column = column + 1
        end


        speaker.playSound(
            "minecraft:block.note_block.harp"
        )

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
