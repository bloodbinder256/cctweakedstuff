local random = require("lib.randomlib")

local monitor = peripheral.find("monitor")

local width, height = monitor.getSize()

local windowLeft, windowMiddle, windowRight

local division = math.floor(width / 3)

print(height)

windowLeft = window.create(monitor, 1, 1, division, height)
windowMiddle = window.create(monitor, division + 1, 1, (division * 2) + 1, height)
windowRight = window.create(monitor, 2 * division + 1, 1, (division * 3) + 1, height)

windowLeft.setBackgroundColor(colors.yellow)
windowMiddle.setBackgroundColor(colors.blue)
windowRight.setBackgroundColor(colors.yellow)

function updateMonitor()
    monitor.clear()
    windowLeft.clear()
    windowMiddle.clear()
    windowRight.clear()
    monitor.setCursorPos(1, 1)
    windowLeft.setCursorPos(1, 1)
    windowLeft.write("Left Window")
    windowMiddle.setCursorPos(1, 1)
    windowMiddle.write("Middle Window")
    windowRight.setCursorPos(1, 1)
    windowRight.write("Right Window")
end

updateMonitor()
