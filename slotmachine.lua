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


-- UI layer
local ui = window.create(monitor, 1, 1, width, height, true)


-- Background
windowLeft.setBackgroundColor(colors.yellow)
windowMiddle.setBackgroundColor(colors.blue)
windowRight.setBackgroundColor(colors.yellow)


local function centerText(win, y, text)
    local w, h = win.getSize()

    win.setCursorPos(
        math.floor((w - #text) / 2) + 1,
        y
    )

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


        win.setTextColor(colors.white)

        win.setCursorPos(
            x + math.floor((self.width - #self.text) / 2),
            y + math.floor(self.height / 2)
        )

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



local symbols = {
    "7",
    "BAR",
    "C",
    "$",
    "*"
}


local reels = {
    1,
    1,
    1
}



local function drawReels()
    local reelText =
        "[ " .. symbols[reels[1]]
        .. " ]  [ " .. symbols[reels[2]]
        .. " ]  [ " .. symbols[reels[3]]
        .. " ]"


    ui.setCursorPos(
        math.floor((width - #reelText) / 2) + 1,
        5
    )

    ui.setBackgroundColor(colors.gray)
    ui.setTextColor(colors.white)

    ui.write(reelText)
end



local function spin()
    for i = 1, 10 do
        local nums = random.generate(3, 1, #symbols)

        reels[1] = nums[1]
        reels[2] = nums[2]
        reels[3] = nums[3]

        ui.clear()

        drawReels()

        startButton:draw(
            ui,
            math.floor((width - 10) / 2),
            8
        )

        ui.redraw()

        sleep(0.1)
    end
end



-- Draw background

windowLeft.clear()
windowMiddle.clear()
windowRight.clear()

centerText(windowLeft, 1, "Spin")
centerText(windowMiddle, 1, "The")
centerText(windowRight, 1, "Lever!")

windowLeft.redraw()
windowMiddle.redraw()
windowRight.redraw()



-- Button

startButton = Button(
    "START",
    colors.green,
    10,
    3
)


ui.clear()


drawReels()


startButton:draw(
    ui,
    math.floor((width - 10) / 2),
    8
)


ui.redraw()



-- Touch loop

while true do
    local event, side, x, y = os.pullEvent("monitor_touch")


    if startButton:isClicked(x, y) then
        spin()
    end
end
