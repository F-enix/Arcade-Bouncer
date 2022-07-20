                -- Collision Function --


local collision = {}


-- Checks if the ball overlap other objects 
function collision.ball_obj(ball, stable)
    local overlap = {}
    -- Check for collision
    if (ball.x + ball.r > stable.x and ball.x < stable.x + stable.width + ball.r and 
        ball.y < stable.y + stable.height + ball.r and ball.y + ball.r > stable.y) then
        -- Compare from which side the center of the ball
        -- getting close to the center of the object
        if ball.x < (stable.x + stable.width/2) then
            overlap.x = (ball.x + ball.r) - stable.x
        else
            overlap.x = (ball.x - ball.r) - (stable.x + stable.width)
        end
        if ball.y < (stable.y + stable.height/2) then
            overlap.y = (ball.y + ball.r) - stable.y
        else
            overlap.y = (ball.y - ball.r) - (stable.y + stable.height)
        end
        collision.rebound(overlap)
        return true
    end
    return false
end

-- Redirect the Ball to another direction so it seems like natural bounce
function collision.rebound( overlap )
    -- Checking the from which side the ball collides
    local min_shift = math.min(math.abs(overlap.x), math.abs(overlap.y))
    if math.abs(overlap.x) == min_shift then
       overlap.y = 0
    else
       overlap.x = 0
    end
    -- Move the ball a little so we avoid typical bugs
    ball.x = ball.x - overlap.x
    ball.y = ball.y - overlap.y
    -- Redirect the ball
    if overlap.x ~= 0 then
       ball.dx = -ball.dx * 1.06 -- and we add more velocity to the ball
    end
    if overlap.y ~= 0 then
       ball.dy = -ball.dy
    end
 end

return collision
