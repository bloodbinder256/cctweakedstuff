local random = require("lib.randomlib")


-------------------------------------------------
-- SETUP
-------------------------------------------------

local monitor = peripheral.find("monitor")

if not monitor then
    error("Monitor not found!")
end


local speaker = peripheral.find("speaker")
local relay = peripheral.find("redstone_relay")


local width, height = monitor.getSize()



-------------------------------------------------
-- EDIT SLOT SETTINGS
-------------------------------------------------

local symbols = {
    "7",
    "BAR",
    "C",
    "$",
    "*"
}


-- Higher = more common
local chances = {
    ["7"] = 5,
    ["BAR"] = 10,
    ["C"] = 30,
    ["$"] = 20,
    ["*"] = 35
}


local payouts = {

    ["7,7,7"] = "JACKPOT!!!",

    ["BAR,BAR,BAR"] = "BIG WIN!",

    ["C,C,C"] = "CHERRY WIN!",

    ["$,$,$"] = "MONEY WIN!",

    ["*,*,*"] = "STAR WIN!"

}



-------------------------------------------------
-- WINDOWS
-------------------------------------------------

local sideWidth = math.floor(width / 3)
local middleWidth = width - (sideWidth * 2)


local windowLeft =
    window.create(monitor, 1, 1, sideWidth, height)


local windowMiddle =
    window.create(
        monitor,
        sideWidth + 1,
        1,
        middleWidth,
        height
    )


local windowRight =
    window.create(
        monitor,
        sideWidth + middleWidth + 1,
        1,
        sideWidth,
        height
    )


-- UI over everything
local ui =
    window.create(
        monitor,
        1,
        1,
        width,
        height,
        true
    )



-------------------------------------------------
-- SOUND
-------------------------------------------------

local function sound(type)
    if not speaker then
        return
    end


    if type == "spin" then
        speaker.playSound(
            "minecraft:block.note_block.hat"
        )
    elseif type == "win" then
        speaker.playSound(
            "minecraft:entity.player.levelup"
        )
    elseif type == "lose" then
        speaker.playSound(
            "minecraft:block.note_block.bass"
        )
    end
end



-------------------------------------------------
-- BUTTON
-------------------------------------------------

local function Button(text, color, w, h)
    local b = {}


    b.text = text
    b.color = color
    b.width = w
    b.height = h



    function b:draw(win, x, y)
        self.x = x
        self.y = y


        win.setBackgroundColor(self.color)


        for yy = y, y + h - 1 do
            win.setCursorPos(x, yy)

            win.write(
                string.rep(" ", w)
            )
        end


        win.setTextColor(colors.white)


        win.setCursorPos(
            x + math.floor((w - #text) / 2),
            y + math.floor(h / 2)
        )


        win.write(text)
    end

    function b:isClicked(x, y)
        return x >= self.x
            and x < self.x + self.width
            and y >= self.y
            and y < self.y + self.height
    end

    return b
end



-------------------------------------------------
-- SLOT LOGIC
-------------------------------------------------

local reels = {
    "C",
    "C",
    "C"
}



local function weightedRandom()
    local total = 0


    for _, chance in pairs(chances) do
        total = total + chance
    end



    local pick = random.number(1, total)

    local count = 0


    for symbol, chance in pairs(chances) do
        count = count + chance


        if pick <= count then
            return symbol
        end
    end
end



local function checkWin()
    local result =
        reels[1] .. "," ..
        reels[2] .. "," ..
        reels[3]


    return payouts[result]
end



local function drawReels()
    local text =
        "[ " .. reels[1] .. " ]   [ " .. reels[2] .. " ]   [ " .. reels[3] .. " ]"



    ui.setBackgroundColor(colors.gray)

    ui.setTextColor(colors.white)



    ui.setCursorPos(
        math.floor((width - #text) / 2) + 1,
        5
    )


    ui.write(text)
end



-------------------------------------------------
-- SPIN
-------------------------------------------------

local startButton


local function spin()
    sound("spin")


    -- fast spinning

    for i = 1, 15 do
        reels[1] = weightedRandom()
        reels[2] = weightedRandom()
        reels[3] = weightedRandom()


        ui.clear()


        drawReels()


        startButton:draw(
            ui,
            math.floor((width - 10) / 2),
            8
        )


        ui.redraw()


        sleep(0.08)
    end



    -- stop reel 1

    reels[1] = weightedRandom()

    ui.clear()
    drawReels()
    startButton:draw(
        ui,
        math.floor((width - 10) / 2),
        8
    )
    ui.redraw()


    sleep(0.5)



    -- stop reel 2

    reels[2] = weightedRandom()

    ui.clear()
    drawReels()
    startButton:draw(
        ui,
        math.floor((width - 10) / 2),
        8
    )
    ui.redraw()


    sleep(0.5)



    -- stop reel 3

    reels[3] = weightedRandom()




    -- near miss

    if not checkWin() then
        if reels[1] == reels[2] then
            reels[3] = reels[1]
        elseif reels[2] == reels[3] then
            reels[1] = reels[2]
        end
    end



    ui.clear()

    drawReels()


    startButton:draw(
        ui,
        math.floor((width - 10) / 2),
        8
    )



    local result = checkWin()



    ui.setCursorPos(
        math.floor(width / 2) - 5,
        12
    )


    if result then
        sound("win")

        ui.setTextColor(colors.lime)

        ui.write(result)
    else
        sound("lose")

        ui.setTextColor(colors.red)

        ui.write("LOSE")
    end


    ui.redraw()
end



-------------------------------------------------
-- DRAW SCREEN
-------------------------------------------------

windowLeft.setBackgroundColor(colors.yellow)
windowMiddle.setBackgroundColor(colors.blue)
windowRight.setBackgroundColor(colors.yellow)


windowLeft.clear()
windowMiddle.clear()
windowRight.clear()


windowLeft.setCursorPos(2, 1)
windowLeft.write("SPIN")


windowMiddle.setCursorPos(2, 1)
windowMiddle.write("SLOT")


windowRight.setCursorPos(2, 1)
windowRight.write("WIN")


windowLeft.redraw()
windowMiddle.redraw()
windowRight.redraw()



-------------------------------------------------
-- START BUTTON
-------------------------------------------------

startButton =
    Button(
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



-------------------------------------------------
-- MAIN LOOP
-------------------------------------------------

while true do
    local event, a, x, y =
        os.pullEvent()



    if event == "monitor_touch" then
        if startButton:isClicked(x, y) then
            spin()
        end
    elseif event == "redstone" then
        if relay and relay.getInput("front") then
            spin()
        end
    end
end
