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

local function Button(text, color, sizex, sizey)
    local button = {}

    button.text = text
    button.color = color
    button.width = sizex
    button.height = sizey

    function button:draw(x, y)
        self.x = x
        self.y = y

        term.setBackgroundColor(self.color)

        for yy = y, y + self.height - 1 do
            term.setCursorPos(x, yy)
            term.write(string.rep(" ", self.width))
        end

        term.setCursorPos(
            x + math.floor((self.width - #self.text) / 2),
            y + math.floor(self.height / 2)
        )

        term.setBackgroundColor(self.color)
        term.setTextColor(colors.white)
        term.write(self.text)
    end

    function button:isClicked(mx, my)
        return mx >= self.x
            and mx < self.x + self.width
            and my >= self.y
            and my < self.y + self.height
    end

    return button
end

local function Title(win, text)
    local w, h = win.getSize()
    local x = math.floor((w - #text) / 2) + 1

    win.setCursorPos(w / 2 - 1, 1)
    win.write(text)
end

local function updateMonitor()
    monitor.setBackgroundColor(colors.black)
    monitor.clear()

    windowLeft.clear()
    windowMiddle.clear()
    windowRight.clear()

    Title(windowLeft, "Spin")
    Title(windowMiddle, " The")
    Title(windowRight, "Lever!")

    windowLeft.redraw()
    windowMiddle.redraw()
    windowRight.redraw()
end

local button = Button("START", colors.green, 10, 3)

button:draw(5, 5)


while true do
    local event, buttonNum, x, y = os.pullEvent("mouse_click")

    if button:isClicked(x, y) then
        print("Button pressed!")
    end
end

updateMonitor()
