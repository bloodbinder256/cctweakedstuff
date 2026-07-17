local random = require("lib.randomlib")

local monitor = peripheral.find("monitor")

local width, height = monitor.getSize()

print("Monitor size: " .. width .. "x" .. height)