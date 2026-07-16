package.path = package.path .. ";/lib/?.lua"

local random = require("lib/randomlib")

local cb = peripheral.find("chat_box")
local speaker = peripheral.find("speaker")
local monitor = peripheral.find("monitor")
local relay = peripheral.find("redstone_relay")
local modem = peripheral.find("modem")

if not cb then error("No Chat Box found!") end
if not speaker then error("No Speaker found!") end
if not monitor then error("No Monitor found!") end
if not relay then error("No Redstone Relay found!") end
if not modem then error("No Modem found!") end


speaker.stop()


local numberCount = 1
local channel = 1234


if not modem.isOpen(channel) then
    modem.open(channel)
end


local function updateMonitor()
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Amount: " .. numberCount)
end


local function generate(player)
    cb.sendMessageToPlayer(
        "Generating " .. numberCount .. " numbers...",
        player
    )

    monitor.clear()

    local vars = random.generate(numberCount, 1, 1000)

    for i, value in ipairs(vars) do
        monitor.setCursorPos(1, i)
        monitor.write(("var%d: %d"):format(i, value))

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
        local left = relay.getInput("left")
        local right = relay.getInput("right")
        local top = relay.getInput("top")
        local front = relay.getInput("front")


        if right and not lastRight then
            numberCount = numberCount + 1
            updateMonitor()
        end


        if left and not lastLeft then
            numberCount = math.max(1, numberCount - 1)
            updateMonitor()
        end


        if top and not lastTop then
            monitor.clear()
        end


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




local function modemWatcher()
    while true do
        local event, side, ch, reply, message =
            os.pullEvent("modem_message")


        if ch == channel then
            if message == "generate" then
                generate("Wireless")
            elseif message == "add" then
                numberCount = numberCount + 1
                updateMonitor()
            elseif message == "remove" then
                numberCount = math.max(1, numberCount - 1)
                updateMonitor()
            elseif message == "reset" then
                monitor.clear()
            end
        end
    end
end




local function chatWatcher()
    while true do
        local event, username, message =
            os.pullEvent("chat")


        if message:lower() == "generate" then
            generate(username)
        end
    end
end



updateMonitor()


parallel.waitForAny(
    buttonWatcher,
    modemWatcher,
    chatWatcher
)
