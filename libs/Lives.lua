            -- Lives Class --

-- Represents the how many remaning credits (or lives)
-- the user currently have starting on 3.

Lives = Class{}

function Lives:init()
    self.x = 650
    self.y = 13
    self.r = 4
    self.hor_d = 4
    self.credits = 3
    self.current_c = {}
end

-- Update the remaining credits
function Lives:update()
    self.credits = self.credits - 1
    table.remove(self.current_c)
end

-- Loads the starting credits
function Lives:load()
    for l = 1, self.credits do
        new_x = self.x + (16 + self.hor_d) * l
        table.insert(self.current_c, {x = new_x})
    end
end

-- Render heart-shaped sketch depends on remaning credits
function Lives:render()
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Credits:", 600, 10, VIRTUAL_WIDTH, "left")
    for _, credit in pairs(self.current_c) do
        love.graphics.circle("fill", credit.x, self.y, self.r)
        love.graphics.circle("fill", credit.x+8, self.y, self.r)
        local vertices = {credit.x-4,self.y, credit.x+12,self.y, credit.x+4,self.y+11}
        love.graphics.polygon("fill", vertices)
    end

end
