                -- Bricks Class --

-- Represents the Bricks that have different build on each lvl,
-- in addition more durability (times the ball need to hit them to brake)
-- to increase difficulty.

Bricks = Class{}

function Bricks:init()
    self.x = 45
    self.y = 50
    self.width = 50
    self.height = 20
    self.hor_d = 5
    self.ver_d = 5
    self.current_lvl = {}
end

-- Removes a brick if the broke it
function Bricks:remove(i)
    table.remove(self.current_lvl, i)
end

-- Renders the Bricks of current lvl on our screen
function Bricks:render()
    for _, brick in pairs(self.current_lvl) do
        if brick.durability > 2 then
            love.graphics.setColor(0,0,1)
        elseif brick.durability == 2 then
            love.graphics.setColor(1,0,0)
        else
            love.graphics.setColor(0,1,0)
        end
        love.graphics.rectangle("line", brick.x, brick.y, brick.width, brick.height)
    end
end

-- Creates the current level of bricks from a specific level table
function Bricks:construct(lvl)
    for i, row in ipairs(lvl) do -- row = 1, self.rows do
        for j, durability in ipairs(row) do -- col = 1, self.columns do
            local new_x = self.x + (j - 1) * (self.width + self.hor_d)
            local new_y = self.y + (i - 1) * (self.height + self.ver_d)
            if durability > 0 then
                table.insert( self.current_lvl, {x = new_x, y = new_y, width = self.width, height = self.height, durability = durability})
            end
        end
    end
end
