local random = require("lib.randomlib")

local monitor = peripheral.find("monitor")
if not monitor then
    error("Monitor not found!")
end

local width, height = monitor.getSize()

-- Left and right are equal, middle gets the remainder
local sideWidth = math.floor(width / 3)
local middleWidth = width - (sideWidth * 2)

local windowLeft = window.create(monitor, 1, 1, sideWidth, height)
local windowMiddle = window.create(monitor, sideWidth + 1, 1, middleWidth, height)
local windowRight = window.create(
    monitor,
    sideWidth + middleWidth + 1,
    1,
    sideWidth,
    height
)

windowLeft.setBackgroundColor(colors.yellow)
windowMiddle.setBackgroundColor(colors.blue)
windowRight.setBackgroundColor(colors.yellow)

windowLeft.setVisible(true)
windowMiddle.setVisible(true)
windowRight.setVisible(true)

local function updateMonitor()
    monitor.clear()

    windowLeft.clear()
    windowMiddle.clear()
    windowRight.clear()

    windowLeft.setCursorPos(1, 1)
    windowLeft.write("Left Window")

    windowMiddle.setCursorPos(1, 1)
    windowMiddle.write("Middle Window")

    windowRight.setCursorPos(1, 1)
    windowRight.write("Right Window")

    windowLeft.redraw()
    windowMiddle.redraw()
    windowRight.redraw()
end

updateMonitor()
