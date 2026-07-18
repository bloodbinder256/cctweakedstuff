local random = require("lib.randomlib")

local monitor = peripheral.find("monitor")
if not monitor then
    error("Monitor not found!")
end

local width, height = monitor.getSize()

-- Split screen
local sideWidth = math.floor(width / 3)
local middleWidth = width - (sideWidth * 2)

local windowLeft = window.create(monitor, 1, 1, sideWidth, height)
local windowMiddle = window.create(monitor, sideWidth + 1, 1, middleWidth, height)
local windowRight = window.create(monitor, sideWidth + middleWidth + 1, 1, sideWidth, height)

-- UI layer (draws over everything)
local ui = window.create(monitor, 1, 1, width, height, true)


-- Background colors
windowLeft.setBackgroundColor(colors.yellow)
windowMiddle.setBackgroundColor(colors.blue)
windowRight.setBackgroundColor(colors.yellow)

windowLeft.setTextColor(colors.white)
windowMiddle.setTextColor(colors.white)
windowRight.setTextColor(colors.white)


local function Title(win, text)
    local w, h = win.getSize()
    local x = math.floor((w - #text) / 2) + 1

    win.setCursorPos(x, 1)
    win.write(text)
end


local function Button(text, color, sizex, sizey)
    local button = {}

    button.text = text
    button.color = color
    button.width = sizex
    button.height = sizey


    function button:draw(win, x, y)
        self.x = x
        self.y = y

        win.setBackgroundColor(self.color)

        for yy = y, y + self.height - 1 do
            win.setCursorPos(x, yy)
            win.write(string.rep(" ", self.width))
        end

        win.setCursorPos(
            x + math.floor((self.width - #self.text) / 2),
            y + math.floor(self.height / 2)
        )

        win.setTextColor(colors.white)
        win.write(self.text)
    end


    function button:isClicked(x, y)
        return x >= self.x
        and x < self.x + self.width
        and y >= self.y
        and y < self.y + self.height
    end


    return button
end


local function SlotBar(win, x, y)
    win.setBackgroundColor(colors.gray)
    win.setTextColor(colors.white)

    win.setCursorPos(x, y)
    win.write("[   ?   |   ?   |   ?   ]")
end


-- Draw background
windowLeft.clear()
windowMiddle.clear()
windowRight.clear()

Title(windowLeft, "Spin")
Title(windowMiddle, "The")
Title(windowRight, "Lever!")

windowLeft.redraw()
windowMiddle.redraw()
windowRight.redraw()


-- Draw slot machine UI
local startButton = Button("START", colors.green, 10, 3)

startButton:draw(ui, math.floor(width / 2) - 5, 8)

SlotBar(ui, math.floor(width / 2) - 10, 4)

ui.redraw()


-- Button detection
while true do
    local event, side, x, y = os.pullEvent("monitor_touch")

    if startButton:isClicked(x, y) then
        
        ui.setCursorPos(1, 12)
        ui.setBackgroundColor(colors.black)
        ui.write("Spinning...")

        ui.redraw()

        sleep(1)

        ui.setCursorPos(1, 12)
        ui.write("Result: 7 7 7")
        ui.redraw()
    end
end