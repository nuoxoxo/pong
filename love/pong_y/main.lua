Class = require 'class'
push = require 'push'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1152
-- 1024     1152
WINDOW_HEIGHT = 648
-- 576      648

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


-------------------------------------
------    LOAD FUNCTION    ------
-------------------------------------

function love.load() 

    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    love.window.setTitle('PONG')
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    
    helloFont = love.graphics.newFont('04B_03__.ttf', 8)
    scoreFont = love.graphics.newFont('04B_03__.ttf', 32)
    victoryFont = love.graphics.newFont('04B_03__.ttf', 16)

    love.graphics.setFont(helloFont)

    -- Table Of "[ key ] = value" PAIR
    sounds = {
        ['hit_pad'] = love.audio.newSource('hit_pad.wav', 'static'),
        ['hit_wall'] = love.audio.newSource('hit_wall.wav', 'static'),
        ['drown'] = love.audio.newSource('drown.wav', 'static')
    } -- A Table of 3 Audio Objects

    PADDLE_SPEED = 160

    AIMODE = false

    math.randomseed(os.time())

    player1Score = 0
    player2Score = 0

    servingPlayer = math.random(2) == 1 and 1 or 2


    winningPlayer = 0


    paddle1 = Paddle(8, 20, 8, 32)
    paddle2 = Paddle(VIRTUAL_WIDTH - 16, VIRTUAL_HEIGHT - 28, 8, 32)

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    

    -- --> OOP
    -- BALL(X, Y)
    -- ballX = VIRTUAL_WIDTH / 2 - 2
    -- ballY = VIRTUAL_HEIGHT / 2 - 2

    -- --> OOP
    -- math.random(2) == 1 ? -100 : 100
    -- ternary syntax in lua
    -- ballDX = math.random(2) == 1 and -100 or 100
    -- ballDY = math.random(-50, 50)

    gameState = 'start' 
end


function love.resize(w, h)
    push:resize(w, h)
end


----------------------------------------
------    UPDATE FUNCTION    ------
----------------------------------------

function love.update(dt)

    if gameState == 'play' then
        if ball.x <= 0 then
            sounds['drown']:play()
            player2Score = player2Score + 1
            servingPlayer = 1
            ball:reset()
            if player2Score >= 3 then
                gameState = 'victory'
                winningPlayer = 2
            else
                -- ball.dx = 100
                gameState = 'serve'
            end
        end

        if ball.x > VIRTUAL_WIDTH - 4 then
            sounds['drown']:play()
            player1Score = player1Score + 1
            servingPlayer = 2
            ball:reset()

            if player1Score >= 3 then
                gameState = 'victory'
                winningPlayer = 1
            else
                -- ball.dx = -100
                gameState = 'serve'
            end

            -- ball.dx = -100
            -- gameState = 'serve'
        end

        if ball:collides(paddle1) then
            ball.dx = -ball.dx

            sounds['hit_pad']:play()
        end

        if ball:collides(paddle2) then
            ball.dx = -ball.dx

            sounds['hit_pad']:play()
        end

        if ball.y <= 0 then
            sounds['hit_wall']:play()
            ball.dy = -ball.dy
            ball.y = 0 
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            sounds['hit_wall']:play()
            ball.dy = -ball.dy
            ball.y = VIRTUAL_HEIGHT - 4
        end
    end 


    paddle1:update(dt)
    paddle2:update(dt)
    

    ----------------------------
    ------    PLAYER 1   ------
    ----------------------------
    
    if love.keyboard.isDown('w') then
        -- UP IS NEGATIVE, DOWN POSITIVE
        paddle1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        paddle1.dy = PADDLE_SPEED
    else
        paddle1.dy = 0
    end

    ----------------------------
    ------    PLAYER 2   ------
    ----------------------------
    
    if AIMODE then
        
        paddle1.y = ball.y
        -- NOW IT FOLLOWS THE BALL
        ------------------------------------------
        ------   SHOULD ADD RANDOM   -----
        ------------------------------------------

    else
        if love.keyboard.isDown('up') then
            paddle2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            paddle2.dy = PADDLE_SPEED
        else
            paddle2.dy = 0
        end
    end 

    -------------------------------
    ------    GAMESTATE    ------
    -------------------------------
    
    if gameState == 'play' then
        ball:update(dt)
    end
end

-- ESC = escape
function love.keypressed(key)

    if key == 'a' and gameState == 'start' then
        AIMODE = true
    end

    if key == 'escape' then
        love.event.quit()
    elseif key == 'space' or key == 'return' or key == 'a' then
        if gameState == 'start' then
            gameState = 'serve' 
        elseif gameState == 'victory' then
            gameState = 'start'

            player1Score = 0
            player2Score = 0

        elseif gameState == 'serve' then 
            gameState = 'play'
        end
    end
end



-------------------------------------
------    DRAW FUNCTION    ------
-------------------------------------



function love.draw()

    push:apply('start')

    -- love.graphics.clear(40, 45, 52, 255)
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(helloFont)

    if gameState == 'start' then
        love.graphics.printf("Hello Pong!", 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter/Space to Play!", 0, 32, VIRTUAL_WIDTH, 'center')
    
    elseif gameState == 'serve' then
        love.graphics.printf("Player " .. tostring(servingPlayer) .. "'s turn", 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter/Space to Serve!", 0, 32, VIRTUAL_WIDTH, 'center')
    
    elseif gameState == 'victory' then
        love.graphics.setFont(victoryFont)
        love.graphics.printf("Player " .. tostring(winningPlayer) .. " wins", 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("Press Enter or Space!", 0, VIRTUAL_HEIGHT - 64, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then

end
    
    
    ------ CHANGE to scoring
    -- if gameState == 'start' then
    --     love.graphics.printf('Press ENTER or SPACE', 0, 20, VIRTUAL_WIDTH, 'center')
    -- elseif gameState == 'play' then
    --     love.graphics.printf('Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    -- end

    
    
    
    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 120 -16, VIRTUAL_HEIGHT / 11 )
    love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 120, VIRTUAL_HEIGHT / 11 )


    -- BALL
    -- love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    ball:render()

    -- PADDLE
    paddle1:render()
    paddle2:render()

    -- LEFT PADDLE
    -- 8PX FROM LEFT, 20 FROM TOP, 8 WIDE, 40 TALL
    -- love.graphics.rectangle('line', 8, player1Y, 8, 32)
    
    -- RIGHT PADDLE (FONT SIZE INCL)
    -- 16 FROM RIGHT, 60 (TALL 40 + MARGING 20) FROM BOTTOM
    -- 8 WIDE, 40 TALL
    -- love.graphics.rectangle('fill', VIRTUAL_WIDTH - 16, player2Y, 8, 32)

    -- displayFPS()

    push:apply('end')

end


-- function displayFPS()

--     love.graphics.setColor(0, 1, 0, 1)
--     love.graphics.setFont(helloFont)
--     love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 20, 10)
--     love.graphics.setColor(1, 1, 1, 1)

-- end