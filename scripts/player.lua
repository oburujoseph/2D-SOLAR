-----------------------------------------------------------------------------------------
-- scripts/player.lua
-----------------------------------------------------------------------------------------

local Player = {}

function Player.new(sceneGroup)

    local ship = display.newImageRect(
        sceneGroup,
        "assets/images/spaceship.png",
        90,
        90
    )

    ship.x = display.contentCenterX
    ship.y = display.contentHeight - 100

    function ship:move(event)

        if event.phase == "began" or event.phase == "moved" then

            self.x = event.x

            if self.x < 45 then
                self.x = 45
            end

            if self.x > display.contentWidth - 45 then
                self.x = display.contentWidth - 45
            end

        end

        return true

    end

    Runtime:addEventListener("touch", ship)

    return ship

end

return Player