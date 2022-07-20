                -- Play State --

-- In Play state the ball starts to bounce on objects collects points
-- from downgrade or brake bricks and lose credits if the user fails
-- to hit ball with the paddle and pass the X axis of the paddle.

-- Include the libraries we created for our game
require "libs/Walls"
require "libs/Bricks"
require "libs/Paddle"
require "libs/Ball"
require "libs/Lives"
local collision = require "libs/collision"
local walls = Walls()
pad = Paddle()
ball = Ball()
bricks = Bricks()
lives = Lives()

local play = {}

-- The logic and functionality of our play mode
function play.update(dt)
    pad:update(dt, walls.thick)
    ball:update(dt, walls.thick)
    -- Checks if the ball touch the paddle and bounce the ball accordingly
    if collision.ball_obj(ball, pad) then
        pad.dx = pad.dx * 1.01
        gSounds['paddle_hit']:play()
    end
    -- Checks if the ball touch each brick to bounce the ball accordingly and downgrade the durability or removes the brick
    for i, brick in pairs(bricks.current_lvl) do
        if collision.ball_obj(ball, brick) then
            brick.durability = brick.durability-1
            if brick.durability < 1 then
                bricks:remove(i)
                game.score = game.score + 10
            end
            game.score = game.score + 5
            gSounds['brick_hit']:play()
        end
    end
    -- Check if all bricks are clear to continue to the next lvl or victory state
    if next(bricks.current_lvl) == nil then
        if levels.current < 3 then
            game.state = 'serve'
            levels.current = levels.current + 1
            levels.load_lvl()
            gSounds['serve']:play()
        else
            game.state = 'victory'
        end
    end

    -- !!!! Uncoment this section to pass the levels with the "c" button
    -- used while developing the game for tests.
    -- if love.keyboard.wasPressed('c') then
    --     bricks.current_lvl = {}
    -- end
    -- Checks if the paddle fails to catch the ball and falls under

    if ball.y >= VIRTUAL_HEIGHT then
        lives:update()
        if lives.credits <= 0 then
            game.state = 'game_over'
            love.filesystem.append("scores.lst", game.score .. "\n")
        else
            game.state = 'serve'
        end
        gSounds['credit_lose']:play()
    end
end

-- Render the required objects for the play mode
function play.render()
    -- Adding a color filter to our background for the play mode
    love.graphics.setColor(love.math.colorFromBytes(200,255,255))
    -- Loading a specific background for current level
    local lvl = "lvl" .. tostring(levels.current)
    love.graphics.draw(gBackground[lvl], 0, 0, 0, VIRTUAL_WIDTH / (gBackground[lvl]:getWidth()-1), VIRTUAL_HEIGHT / (gBackground[lvl]:getHeight()-1))
    love.graphics.setColor(0,0,1)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Score: ' .. game.score, 0, 10, VIRTUAL_WIDTH, 'center')
    walls:render()
    bricks:render()
    lives:render()
    pad:render()
    ball:render()
end

return play