-----------------------------------------------------------------------------------------
-- scenes/menu.lua
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

-----------------------------------------------------------------------------------------
-- CREATE SCENE
-----------------------------------------------------------------------------------------
function scene:create(event)

    local sceneGroup = self.view

    -------------------------------------------------
    -- Background
    -------------------------------------------------
    local background = display.newImageRect(
        sceneGroup,
        "assets/images/background.png",
        display.actualContentWidth,
        display.actualContentHeight
    )

    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -------------------------------------------------
    -- Title
    -------------------------------------------------
    local title = display.newText({
        parent = sceneGroup,
        text = "SPACE SURVIVOR",
        x = display.contentCenterX,
        y = 70,
        font = native.systemFontBold,
        fontSize = 40
    })

    title:setFillColor(1,1,1)

    -------------------------------------------------
    -- Version
    -------------------------------------------------
    local version = display.newText({
        parent = sceneGroup,
        text = "Version 1.0",
        x = display.contentCenterX,
        y = 110,
        font = native.systemFont,
        fontSize = 18
    })

    version:setFillColor(1,1,1)

    -------------------------------------------------
    -- Spaceship
    -------------------------------------------------
    local ship = display.newImageRect(
        sceneGroup,
        "assets/images/spaceship.png",
        150,
        150
    )

    ship.x = display.contentCenterX
    ship.y = 250

    transition.to(ship,{
        time = 1500,
        y = 235,
        iterations = 0,
        transition = easing.continuousLoop
    })

    -------------------------------------------------
    -- START BUTTON
    -------------------------------------------------
    local startButton = display.newRoundedRect(
        sceneGroup,
        display.contentCenterX,
        420,
        240,
        60,
        12
    )

    startButton:setFillColor(0.0,0.6,1.0)

    local startText = display.newText({
        parent = sceneGroup,
        text = "START GAME",
        x = display.contentCenterX,
        y = 420,
        font = native.systemFontBold,
        fontSize = 24
    })

    startText:setFillColor(1,1,1)

    -------------------------------------------------
    -- EXIT BUTTON
    -------------------------------------------------
    local exitButton = display.newRoundedRect(
        sceneGroup,
        display.contentCenterX,
        500,
        240,
        60,
        12
    )

    exitButton:setFillColor(0.9,0.2,0.2)

    local exitText = display.newText({
        parent = sceneGroup,
        text = "EXIT",
        x = display.contentCenterX,
        y = 500,
        font = native.systemFontBold,
        fontSize = 24
    })

    exitText:setFillColor(1,1,1)

    -------------------------------------------------
    -- START GAME FUNCTION
    -------------------------------------------------
    local function startGame()

        composer.gotoScene("scenes.game", {
            effect = "fade",
            time = 500
        })

    end

    -------------------------------------------------
    -- EXIT GAME FUNCTION
    -------------------------------------------------
    local function exitGame()

        native.requestExit()

    end

    -------------------------------------------------
    -- Button Listeners
    -------------------------------------------------
    startButton:addEventListener("tap", startGame)
    startText:addEventListener("tap", startGame)

    exitButton:addEventListener("tap", exitGame)
    exitText:addEventListener("tap", exitGame)

end

-----------------------------------------------------------------------------------------
-- SHOW
-----------------------------------------------------------------------------------------
function scene:show(event)

    if event.phase == "did" then
        print("Menu Loaded")
    end

end

-----------------------------------------------------------------------------------------
-- HIDE
-----------------------------------------------------------------------------------------
function scene:hide(event)

end

-----------------------------------------------------------------------------------------
-- DESTROY
-----------------------------------------------------------------------------------------
function scene:destroy(event)

end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene