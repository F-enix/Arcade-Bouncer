            -- Walls Class --

-- A class we state our walls thickness for out texture
-- and render method.

Walls = Class{}


function Walls:init()
    self.thick = 30
end

function Walls:render()
    -- Setting wall colors to yellow
    love.graphics.setColor(love.math.colorFromBytes(250,255,0))
    -- left wall
    love.graphics.rectangle("fill", 0, 0, self.thick, H)
    -- top wall
    love.graphics.rectangle("fill", 0, 0, W, self.thick)
    -- right wall
    love.graphics.rectangle("fill", W-self.thick, 0, self.thick, H)
end
