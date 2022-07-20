                -- Game Mode --

-- Here we initialize our resources and variables, split
-- our code in smaller parts so it can be read easier and
-- use other global love functions we need.

-- Include the chunks of code we splited
local menu = require "states/menu"
local serve = require "states/serve"
local play = require "states/play"
local victory = require "states/victory"
local gameOver = require "states/gameOver"
levels = require "lvls/levels"

-- Game.state can be any of the following: 
-- 1. "menu" (the beginning of the game, before serve of the ball),
-- 2. "serve" (waiting on a key press to serve the ball),
-- 3. "play" (the ball is in play, bouncing between objects),
-- 4. "victory" (the player finished all 3 levels and the game is over),
-- 5. "game_over" (the game is over, showing the high scores, ready for restart)
game = {
    state = 'menu',
    score = 0
}


-- Resources and variables initialization
function game.load()
    -- IMAGES for background setup
    gBackground = {
        ['menu'] = love.graphics.newImage('img/menu.jpg'),
        ['lvl1'] = love.graphics.newImage('img/lvl1.jpg'),
        ['lvl2'] = love.graphics.newImage('img/lvl2.jpg'),
        ['lvl3'] = love.graphics.newImage('img/lvl3.jpg'),
        ['high_scores'] = love.graphics.newImage('img/high_scores.jpg'),
        ['end'] = love.graphics.newImage('img/end.jpg')
    }
    -- FONT setup
    gFonts = {
        ['small'] = love.graphics.newFont('font.ttf', 8),
        ['medium'] = love.graphics.newFont('font.ttf', 16),
        ['large'] = love.graphics.newFont('font.ttf', 32)
    }
    -- SOUNDS setup
    gSounds = {
        ['start'] = love.audio.newSource('sounds/start.wav', "static"),
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', "static"),
        ['serve'] = love.audio.newSource('sounds/serve.wav', "static"),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', "static"),
        ['brick_hit'] = love.audio.newSource('sounds/brick_hit.wav', "static"),
        ['credit_lose'] = love.audio.newSource('sounds/credit_lose.wav', "static")
    }

    menu.load()
    levels.load_lvl()
    lives:load()
    love.keyboard.keysPressed = {}
end

function game.update(dt)
    if game.state == 'menu' then
        menu.update()
    elseif game.state == 'serve' then
        serve.update(dt)
    elseif game.state == 'play' then
        play.update(dt)
    elseif game.state == 'victory' then
        victory.update()
    elseif game.state == 'game_over' then
        gameOver.update()
    end
    love.keyboard.keysPressed = {}
end

function game.render()
    if game.state == 'menu' then
        menu.render()
    elseif game.state == 'serve' then
        serve.render()
    elseif game.state == 'play' then
        play.render()
    elseif game.state == 'victory' then
        victory.render()
    elseif game.state == 'game_over' then
        gameOver.render()
    end
        
    -- Frames per second display on top left corner
    love.graphics.setColor(0,1,0)
    displayFPS()
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

-- Gets an input from the User as his name
function love.textinput(t)
    if #user_input < 12 then
        user_input = user_input .. t
    end
end