local random = require("lib.randomlib")

local monitor = peripheral.find("monitor")

local width, height = monitor.getSize()

print("Monitor size: " .. width .. "x" .. height)

local windowLeft, windowMiddle, windowRight

windowLeft = window.create(monitor, 1, 1, width / 3, height)
windowMiddle = window.create(monitor, 1, 1, width / 3, height)
windowRight = window.create(monitor, 1, 1, width / 3, height)

windowLeft.setBackgroundColor(colors.yellow)
windowMiddle.setBackgroundColor(colors.blue)
windowRight.setBackgroundColor(colors.yellow)