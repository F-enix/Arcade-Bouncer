                -- Levels Loader --

-- Global table levels that manage the level loading
-- using lvl1,2,3 lua files.

levels = {
    current = 1
}

-- Load a table for the specific level from a file
function levels.load_file()
    local filename = "lvls/lvl" .. tostring(levels.current)
    local level = require(filename)
    return level
end

-- Initialize current level with different bricks structure
function levels.load_lvl()
    local lvl = levels.load_file()
    bricks:construct(lvl)
end

return levels