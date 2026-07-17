local random = require("lib.randomlib")

local monitor = peripheral.find("monitor")

local width, height = monitor.getSize()

print("Monitor size: " .. width .. "x" .. height)

windowLeft = window.create(monitor, 1, 1, width / 3, height)
windowMiddle = window.create(monitor, 1, 1, width / 3, height)
windowRight = window.create(monitor, 1, 1, width / 3, height)