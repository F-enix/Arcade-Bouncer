                    --++ ARCADE BOUNCER ++--

    -- A simple 2D arcade game that the player have to clear all the bricks on every
    -- level(three levels total) by bouncing a ball with a platform(paddle) that he 
    -- controls without letting the ball pass the X axis of his platform.


-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require "libs/class"

-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
local push = require "libs/push"

-- collision method in charge for ball collision with objects and bounce of them
local collision = require "libs/collision"
require "states/game"

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 800
VIRTUAL_HEIGHT = 450

H = love.graphics.getHeight()
W = love.graphics.getWidth()


function love.load()
    -- Default filter for retro looking graphics
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- Applying name to our application window
    love.window.setTitle("Arcade Bouncer")
    -- Seed our random generator always with a different number
    math.randomseed(os.time())

    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions
    -- or similar love.window.setMode(800, 450, {resizable=true, vsync=true, fullscreen=false})
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true,
    })

    -- Loading our resources
    game.load()
end

function love.update(dt)
    -- Update the game states
    game.update(dt)
end

function love.draw()
    push:apply('start')
    -- Render every state of our game in the screen
    game.render()
    push:apply('end')
end

-- Responsive graphics of our application window
function love.resize(w, h)
    push:resize(w, h)
end