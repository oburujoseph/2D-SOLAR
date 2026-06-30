-------------------------------------------------
-- scripts/asteroid.lua
-------------------------------------------------

local Asteroid = {}

-- Store all active asteroids
Asteroid.list = {}

function Asteroid.spawn(sceneGroup)

    local asteroid = display.newImageRect(
        sceneGroup,
        "assets/images/asteroid.png",
        70,
        70
    )

    if not asteroid then
        print("ERROR: asteroid.png not found!")
        return
    end

    asteroid.x = math.random(40, display.contentWidth - 40)
    asteroid.y = -60

    table.insert(Asteroid.list, asteroid)

    transition.to(asteroid, {

        y = display.contentHeight + 80,

        time = math.random(2500, 4000),

        onComplete = function()

            for i = #Asteroid.list, 1, -1 do

                if Asteroid.list[i] == asteroid then
                    table.remove(Asteroid.list, i)
                    break
                end

            end

            display.remove(asteroid)

        end

    })

    return asteroid

end

return Asteroid