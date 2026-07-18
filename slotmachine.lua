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
local windowRight = window.create(monitor, sideWidth + middleWidth + 1, 1, sideWidth, height)

windowLeft.setBackgroundColor(colors.yellow)
windowMiddle.setBackgroundColor(colors.blue)
windowRight.setBackgroundColor(colors.yellow)

windowLeft.setTextColor(colors.white)
windowMiddle.setTextColor(colors.white)
windowRight.setTextColor(colors.white)

windowLeft.setVisible(true)
windowMiddle.setVisible(true)
windowRight.setVisible(true)

local function centerText(win, text)
    local w, h = win.getSize()
    local x = math.floor((w - #text) / 2) + 1
    local y = math.floor(h / 2) + 1

    win.setCursorPos(x, y)
    win.write(text)
end

local function Title(win, text)
    local w, h = win.getSize()
    local x = math.floor((w - #text) / 2) + 1
    local y = math.floor(h)

    win.setCursorPos(x, y)
    win.write(text)
end

local function updateMonitor()
    monitor.setBackgroundColor(colors.black)
    monitor.clear()

    windowLeft.clear()
    windowMiddle.clear()
    windowRight.clear()

    Title(windowLeft, "Spin")
    Title(windowMiddle, "The")
    Title(windowRight, "Lever!")

    windowLeft.redraw()
    windowMiddle.redraw()
    windowRight.redraw()
end

updateMonitor()
