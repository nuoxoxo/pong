WINDOW_WIDTH = 1152
-- 1024     1152
WINDOW_HEIGHT = 648
-- 576      648

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

push = require 'push'

function love.load() 

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    
    helloFont = love.graphics.newFont('04B_03__.ttf', 8)
    scoreFont = love.graphics.newFont('04B_03__.ttf', 32)

    PADDLE_SPEED = 200

    math.randomseed(os.time())


    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 70

    -- BALL(X, Y)
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    -- math.random(2) == 1 ? -100 : 100
    -- ternary syntax in lua
    ballDX = math.random(2) == 1 and -100 or 100
    ballDY = math.random(-50, 50)

    gameState = 'start'

end



function love.update(dt)
    
    -- PLAYER 1
    
    if love.keyboard.isDown('w') then
        -- UP IS NEGATIVE, DOWN POSITIVE
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 32, player1Y + PADDLE_SPEED * dt)
    end

    -- PLAYER 2
    
    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 32, player2Y + PADDLE_SPEED * dt)
    end 

    -- GAMESTATE
    
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end


-- ESC = escape
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'space' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        elseif gameState == 'play' then

            gameState = 'start'

            -- RESET BALL
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            ballDX = math.random(2) == 1 and -100 or 100
            ballDY = math.random(-50, 50)

        end
    end
end


function love.draw()

    push:apply('start')

    -- love.graphics.clear(40, 45, 52, 255)
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(helloFont)
    if gameState == 'start' then
        love.graphics.printf('Press ENTER or SPACE', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        love.graphics.printf('Pong!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(scoreFont)
    love.graphics.print(player1Score, VIRTUAL_WIDTH / 2 - 36, VIRTUAL_HEIGHT / 5 )
    love.graphics.print(player2Score, VIRTUAL_WIDTH / 2 + 20, VIRTUAL_HEIGHT / 5 )


    -- BALL
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)


    -- LEFT PADDLE
    -- 8PX FROM LEFT, 20 FROM TOP, 8 WIDE, 40 TALL
    love.graphics.rectangle('line', 8, player1Y, 8, 32)
    
    -- RIGHT PADDLE (FONT SIZE INCL)
    -- 16 FROM RIGHT, 60 (TALL 40 + MARGING 20) FROM BOTTOM
    -- 8 WIDE, 40 TALL
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 16, player2Y, 8, 32)

    push:apply('end')

end