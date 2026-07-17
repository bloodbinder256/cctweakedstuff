local random = require("lib.randomlib")

local monitor = peripheral.find("monitor")

local width, height = monitor.getSize()

local windowLeft, windowMiddle, windowRight

local division = math.floor(width / 3)

print("Monitor size: " .. width .. "x" .. height)

function updateMonitor()
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.windowLeft.setCursorPos(1, 1)
    monitor.windowLeft.write("Left Window")
    monitor.windowMiddle.setCursorPos(1, 1)
    monitor.windowMiddle.write("Middle Window")
    monitor.windowRight.setCursorPos(1, 1)
    monitor.windowRight.write("Right Window")
end

windowLeft = window.create(monitor, 1, 1, division, height)
windowMiddle = window.create(monitor, division + 1, 1, division * 2, height)
windowRight = window.create(monitor, 2 * division + 1, 1, division * 3, height)

windowLeft.setBackgroundColor(colors.yellow)
windowMiddle.setBackgroundColor(colors.blue)
windowRight.setBackgroundColor(colors.yellow)

updateMonitor()
