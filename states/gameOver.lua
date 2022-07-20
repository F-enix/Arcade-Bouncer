                -- Game Over State --

-- In this state we display the records(names and scores) of our database
-- initialize our required variables for a new game, the user can wipe
-- the database records(created for Development reasons but decided to use it)
-- and by pressing ENTER return on Menu screen to start over again.

require "libs/Bricks"
require "libs/Lives"

local gameOver = {}


-- State logic and variables initialization
function gameOver.update()
    -- Deletes high scores record from our list by pressing delete key
    if love.keyboard.wasPressed('delete') then
        love.filesystem.write("scores.lst", "Player\nScore\n")
    end
    -- Resets variables and redirects the user to the Menu screen
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        user_input = ""
        bricks:init()
        lives:init()
        lives:load()
        levels.current = 1
        levels.load_lvl()
        game.state = 'menu'
        game.score = 0
    end
end

-- UI messages
function gameOver.render()
    love.graphics.draw(gBackground['high_scores'], 0, 0, 0, VIRTUAL_WIDTH / (gBackground['high_scores']:getWidth()-1), VIRTUAL_HEIGHT / (gBackground['high_scores']:getHeight()-1))
    love.graphics.setColor(1,1,0)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("~ PLAYERS SCORES ~", 0, 50, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    -- Renders the names and scores from our list every two lines into one line in our screen
    local i = 0
    for line in love.filesystem.lines("scores.lst") do
        i = i + 9
        if i % 2 == 0 then
            love.graphics.printf(line, 400, 90+(i - 9), VIRTUAL_WIDTH/2, 'center')
        else
            love.graphics.printf(line, 300, 90+i, VIRTUAL_WIDTH/2, 'center')
        end
    end
    love.graphics.printf("Press DELETE to clear score history", 10, 100, VIRTUAL_WIDTH, 'left')
    love.graphics.printf("or Press ENTER to return to Staring Menu ", 10, 150, VIRTUAL_WIDTH, 'left')
end

return gameOver