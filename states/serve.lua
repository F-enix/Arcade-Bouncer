                -- Serve State --

-- In Serve state the user can only move the paddle waiting 
-- for him to press space to serve the ball and start playing

require "libs/Walls"
local walls = Walls()

local serve = {}


-- Constant update of paddle and ball(stuck on paddle) position
function serve.update(dt)
    pad:update(dt, walls.thick)
    ball:reset()
    if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('up') then
        game.state = 'play'
        ball:random_start()
        gSounds['serve']:play()
    end
end

-- Render the graphic enviroment of serve state
function serve.render()
    -- picking the right background for our specific lvl
    local lvl = "lvl" .. tostring(levels.current)
    love.graphics.draw(gBackground[lvl], 0, 0, 0, VIRTUAL_WIDTH / (gBackground[lvl]:getWidth()-1), VIRTUAL_HEIGHT / (gBackground[lvl]:getHeight()-1))
    walls:render()
    love.graphics.setColor(0,0,1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Space to serve the BALL!', 0, 10, VIRTUAL_WIDTH, 'center')
    
    pad:render()
    ball:render()
    lives:render()
    bricks:render()
end

return serve