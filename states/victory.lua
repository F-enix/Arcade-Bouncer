                -- Victory State --

-- A screen that congratulates the user if he finish all the levels
-- showing his score and redirects him on the next state(gameOver)
-- by pressing ENTER

local victory = {}


-- Saves users score on our database of scores and proceed on next game state
function victory.update()
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        love.filesystem.append("scores.lst", game.score .. "\n")
        game.state = 'game_over'
        gSounds['credit_lose']:play()
    end
end

-- UI messages
function victory.render()
    love.graphics.draw(gBackground['end'], 0, 0, 0, VIRTUAL_WIDTH / (gBackground['end']:getWidth()-1), VIRTUAL_HEIGHT / (gBackground['end']:getHeight()-1))
    love.graphics.setColor(1,0,0)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Congratulations you WON!', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('You scored ' .. game.score .. ' points', 0, 80, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press enter to continue to high scores', 0, 110, VIRTUAL_WIDTH, 'center')
end

return victory