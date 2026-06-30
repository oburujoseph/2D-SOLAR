-----------------------------------------------------------------------------------------
-- scenes/game.lua
-----------------------------------------------------------------------------------------

local composer = require("composer")
local scene = composer.newScene()

-- Modules
local Player = require("scripts.player")
local Asteroid = require("scripts.asteroid")
local Collision = require("scripts.collision")

-- Variables
local ship
local asteroidGroup
local score = 0
local scoreText
local gameOver = false

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
    -- Score
    -------------------------------------------------

    scoreText = display.newText({
        parent = sceneGroup,
        text = "Score: 0",
        x = 90,
        y = 40,
        font = native.systemFontBold,
        fontSize = 24
    })

    -------------------------------------------------
    -- Asteroid Group
    -------------------------------------------------

    asteroidGroup = display.newGroup()
    sceneGroup:insert(asteroidGroup)

    -------------------------------------------------
    -- Player
    -------------------------------------------------

    ship = Player.new(sceneGroup)

    -------------------------------------------------
    -- Spawn Asteroids
    -------------------------------------------------

    timer.performWithDelay(1000, function()

        if not gameOver then
            Asteroid.spawn(asteroidGroup)
        end

    end, 0)

    -------------------------------------------------
    -- Increase Score
    -------------------------------------------------

    timer.performWithDelay(1000, function()

        if not gameOver then

            score = score + 1
            scoreText.text = "Score: " .. score

        end

    end, 0)

    -------------------------------------------------
    -- Collision Detection
    -------------------------------------------------

    local function checkCollisions()

        if gameOver then
            return
        end

        for i = #Asteroid.list, 1, -1 do

            local asteroid = Asteroid.list[i]

            if asteroid and Collision.check(ship, asteroid) then

                gameOver = true

                print("GAME OVER")

                local gameOverText = display.newText({

                    parent = sceneGroup,
                    text = "GAME OVER",

                    x = display.contentCenterX,
                    y = display.contentCenterY,

                    font = native.systemFontBold,
                    fontSize = 44

                })

                gameOverText:setFillColor(1,0,0)

                -------------------------------------------------
                -- Restart Button
                -------------------------------------------------

                local restartButton = display.newRoundedRect(

                    sceneGroup,

                    display.contentCenterX,
                    display.contentCenterY + 70,

                    220,
                    60,
                    12

                )

                restartButton:setFillColor(0.2,0.8,0.2)

                local restartText = display.newText({

                    parent = sceneGroup,

                    text = "RESTART",

                    x = restartButton.x,
                    y = restartButton.y,

                    font = native.systemFontBold,
                    fontSize = 24

                })

                local function restartGame()

                    composer.removeScene("scenes.game")
                    composer.gotoScene("scenes.game","fade",500)

                end

                restartButton:addEventListener("tap", restartGame)
                restartText:addEventListener("tap", restartGame)

                Runtime:removeEventListener("enterFrame", checkCollisions)

                break

            end

        end

    end

    Runtime:addEventListener("enterFrame", checkCollisions)

end

-----------------------------------------------------------------------------------------
-- SHOW
-----------------------------------------------------------------------------------------

function scene:show(event)

    if event.phase == "did" then

        print("Game Scene Loaded")

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