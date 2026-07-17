local random = require("lib.randomlib")

local monitor = peripheral.find("monitor")

local width, height = monitor.getSize()

print("Monitor size: " .. width .. "x" .. height)

function updateMonitor()
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Monitor size: " .. width .. "x" .. height)
end

local windowLeft, windowMiddle, windowRight

windowLeft = window.create(monitor, 1, 1, width / 3, height)
windowMiddle = window.create(monitor, 1, 1, width / 3, height)
windowRight = window.create(monitor, 1, 1, width / 3, height)

windowLeft.setBackgroundColor(colors.yellow)
windowMiddle.setBackgroundColor(colors.blue)
windowRight.setBackgroundColor(colors.yellow)

updateMonitor()
