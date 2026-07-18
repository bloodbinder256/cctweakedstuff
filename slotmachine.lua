local random = require("lib.randomlib")

local monitor = peripheral.find("monitor")
if not monitor then
    error("Monitor not found!")
end

local width, height = monitor.getSize()

local division = math.floor(width / 3)

local windowLeft = window.create(monitor, 1, 1, division, height)
local windowMiddle = window.create(monitor, division + 1, 1, division, height)
local windowRight = window.create(
    monitor,
    division * 2 + 1,
    1,
    width - (division * 2),
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
