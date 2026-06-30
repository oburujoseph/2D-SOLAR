-------------------------------------------------
-- scripts/collision.lua
-------------------------------------------------

local Collision = {}

function Collision.check(obj1, obj2)

    if obj1 == nil or obj2 == nil then
        return false
    end

    local left1 = obj1.x - obj1.width/2
    local right1 = obj1.x + obj1.width/2
    local top1 = obj1.y - obj1.height/2
    local bottom1 = obj1.y + obj1.height/2

    local left2 = obj2.x - obj2.width/2
    local right2 = obj2.x + obj2.width/2
    local top2 = obj2.y - obj2.height/2
    local bottom2 = obj2.y + obj2.height/2

    return (
        right1 > left2 and
        left1 < right2 and
        bottom1 > top2 and
        top1 < bottom2
    )

end

return Collision