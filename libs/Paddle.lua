            -- Paddle Class --

-- Represents a Platform the player control to bounce
-- the ball upwards else he lose a credit.

Paddle = Class{}

-- Variables initiation
function Paddle:init()
    self.x = 365
    self.y = 420
    self.dx = 300
    self.width = 70
    self.height = 20
end

-- Paddle movement and wall restriction 
function Paddle:update(dt, wall)
    if love.keyboard.isDown("right") then
        self.x = math.min(W -wall -self.width, self.x + (self.dx * dt))
    end
    if love.keyboard.isDown("left") then
        self.x = math.max(wall, self.x - (self.dx * dt))
    end
end

-- Paddle render on our screen
function Paddle:render()
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 8 )
end
