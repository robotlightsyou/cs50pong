VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216
-- DISPLAY_WIDTH, DISPLAY_HEIGHT = love.window.getDesktopDimensions()
-- WINDOW_WIDTH = DISPLAY_WIDTH * 0.75
-- WINDOW_HEIGHT = DISPLAY_HEIGHT * 0.75
-- love.window.setTitle("Pong Seminar Lua Demo")
-- love.window.updateMode(WINDOW_WIDTH, WINDOW_HEIGHT)

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

push = require 'push'

offset = 10
PADDLE_WIDTH = 8
PADDLE_HEIGHT = 32
PADDLE_SPEED = 140

LARGE_FONT = love.graphics.newFont(32)
SMALL_FONT = love.graphics.newFont(16)

BALL_SIZE = 4

player1 = {
    x = offset, y = offset, score = 0
}

player2 = {
    x = VIRTUAL_WIDTH - PADDLE_WIDTH - offset,
    y = VIRTUAL_HEIGHT - PADDLE_HEIGHT - offset,
    score = 0
}

ball = {
    x = VIRTUAL_WIDTH / 2 - BALL_SIZE / 2,
    y = VIRTUAL_WIDTH / 2 - BALL_SIZE / 2,
    dx = 0, dy = 0
}

gameState = 'title'

function love.load()
    math.randomseed(os.time())
    -- setDefaultFilter used to sharpen resolution, I didn't like it with just text.
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)

    resetBall()
end


function love.update(dt)
    if love.keyboard.isDown('e') then
        player1.y = player1.y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('d') then
        player1.y = player1.y + PADDLE_SPEED * dt
    end

    if love.keyboard.isDown('k') then
        player2.y = player2.y - PADDLE_SPEED * dt
    elseif love.keyboard.isDown('j') then
        player2.y = player2.y + PADDLE_SPEED * dt
    end

    if gameState == 'play' then
        ball.x = ball.x + ball.dx * dt
        ball.y = ball.y + ball.dy * dt

        if ball.x <= 0 then
            player2.score = player2.score + 1
            resetBall()
            gameState = 'serve'
        elseif ball.x >= VIRTUAL_WIDTH - BALL_SIZE then
            player1.score = player1.score + 1
            resetBall()
            gameState = 'serve'
        end

        if ball.y <= 0 then
            ball.dy = -ball.dy
        elseif ball.y >= VIRTUAL_HEIGHT - BALL_SIZE then
            ball.dy = -ball.dy
        end

        if collides(player1, ball) then
            ball.dx = -ball.dx * 1.02
            ball.x = player1.x + PADDLE_WIDTH
        elseif collides(player2, ball) then
            ball.dx = -ball.dx * 1.02
            ball.x = player2.x - BALL_SIZE
        end
    end
end


function love.keypressed(key)
    if key == '`' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if gameState == 'title' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        end
    end
end


function love.draw()
    push:start()
    -- clear() takes rgba values from 0 - 1.
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if gameState == 'title' then
        love.graphics.setFont(LARGE_FONT)
        love.graphics.printf("Sem Pong", 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(SMALL_FONT)
        love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT - 32, VIRTUAL_WIDTH, 'center')
    end

    if gameState == 'serve' then
        love.graphics.setFont(SMALL_FONT)
        love.graphics.printf("Press Enter to serve!", 0, 10, VIRTUAL_WIDTH, 'center')
    end

    
    -- paddles
    love.graphics.rectangle('fill', player1.x, player1.y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', player2.x, player2.y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', ball.x, ball.y, BALL_SIZE, BALL_SIZE)

    love.graphics.setFont(LARGE_FONT)
    love.graphics.print(player1.score, VIRTUAL_WIDTH / 2 - 36, VIRTUAL_HEIGHT / 2 - 16)
    love.graphics.print(player2.score, VIRTUAL_WIDTH / 2  + 16, VIRTUAL_HEIGHT / 2 - 16)
    love.graphics.setFont(SMALL_FONT)
    push:finish()
end

function collides(p,b)
    return not (p.x > b.x + BALL_SIZE or p.y > b.y + BALL_SIZE or b.x > p.x + PADDLE_WIDTH or b.y > p.y + PADDLE_HEIGHT)
end

function resetBall()
    ball.x = VIRTUAL_WIDTH / 2 - BALL_SIZE / 2
    ball.y = VIRTUAL_HEIGHT / 2 - BALL_SIZE / 2

    ball.dx = 60 + math.random(60)
    if math.random(2) == 1 then
        ball.dx = -ball.dx
    end
    ball.dy = 30 + math.random(60)
    if math.random(2) == 1 then
        ball.dy = -ball.dy
    end
end
