                -- Menu State --

-- In Menu state we prompt the user for a name and proceed into
-- Serve state after he press ENTER

local menu = {}
user_input = ""


-- Initialize the saving folder and file for our score list
function menu.load()
    love.filesystem.setIdentity('Arcade-bouncer')
    local info = love.filesystem.getInfo("scores.lst")
    if not info then
        love.filesystem.write("scores.lst", "Player\nScore\n")
    end
end

-- The logic in first state Menu. Take the user's input of his given name
-- and append it into our saving file when ENTER is pressed.
function menu.update()
    if love.keyboard.wasPressed("delete") or love.keyboard.wasPressed("backspace") then
        user_input = user_input:sub(1, #user_input-1)
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if user_input == "" then
            user_input = "NoName"
        end
        love.filesystem.append("scores.lst", user_input .. "\n")
        game.state = 'serve'
        gSounds['start']:play()
    end
end

function menu.render()
    -- Render of our Menu background
    love.graphics.draw(gBackground['menu'], 0, 0, 0, VIRTUAL_WIDTH / (gBackground['menu']:getWidth()-1), VIRTUAL_HEIGHT / (gBackground['menu']:getHeight()-1))
    -- UI messages
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Welcome to Arcade Bouncer!', 0, 10, 800, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Please type a name', 0, 60, 800, 'center')
    love.graphics.printf(user_input, 0, 90, 800, 'center')
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Press Enter to Start!', 0, 260, 800, 'center')

end

return menu