                -- Ball Class --

-- Represents a ball which will bounce back and forth between the sides
-- of the world space, the player's paddle, and the bricks laid out above
-- the paddle. In case the player miss to bounce the ball he lose 1 credit.

Ball = Class{}

function Ball:init()
    self.x = 400
    self.y = 393
    self.dx = 200
    self.dy = -200
    self.r = 6
end

-- Placing the ball on top of the pad
function Ball:reset()
    self.x = pad.x + pad.width / 2
    self.y = pad.y - self.r
    self.dx = 0
    self.dy = 0
end

-- Setting random ball serve direction
function Ball:random_start()
    self.dy = -300
    if love.math.random(-1,1) * 100 > 0 then
        self.dx = 200
    else
        self.dx = -200
    end
end

function Ball:update(dt, wall)
    -- Ball position
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- Bounce from left wall
    if self.x <= wall + self.r then        
        self.x = wall + self.r+1
        self.dx = -self.dx
        gSounds['wall_hit']:play()
    end
    -- Bounce from right wall
    if self.x >= VIRTUAL_WIDTH -wall -self.r then
        self.x = VIRTUAL_WIDTH -wall -self.r-1
        self.dx = -self.dx
        gSounds['wall_hit']:play()
    end
    -- Bounce from top wall
    if self.y <= wall + self.r then
        self.y = wall + self.r+1
        self.dy = -self.dy
        gSounds['wall_hit']:play()
    end
    
end

-- Setting the ball to blue color and render it to our screen
function Ball:render()
    love.graphics.setColor(0,0,1)
    love.graphics.circle("fill", self.x, self.y, self.r)
end