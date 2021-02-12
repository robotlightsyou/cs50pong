VIRTUAL_WIDTH = 384
VIRTUAL_HEIGHT = 216
DISPLAY_WIDTH, DISPLAY_HEIGHT = love.window.getDesktopDimensions()
WINDOW_WIDTH = DISPLAY_WIDTH * 0.75
WINDOW_HEIGHT = DISPLAY_HEIGHT * 0.75
love.window.setTitle("Pong Seminar Lua Demo")
love.window.updateMode(WINDOW_WIDTH, WINDOW_HEIGHT)

push = require 'push'

offset = 10
PADDLE_WIDTH = 8
PADDLE_HEIGHT = 32

LARGE_FONT = love.graphics.newFont(32)
SMALL_FONT = love.graphics.newFont(16)

player1 = {
    x = offset, y = offset, score = 0,
}

player2 = {
    -- x = 366,
    -- y = 174,
    x = VIRTUAL_WIDTH - PADDLE_WIDTH - offset,
    y = VIRTUAL_HEIGHT - PADDLE_HEIGHT - offset,
    score = 0,
}


function love.load()
    -- setDefaultFilter used to sharpen resolution, I didn't like it with just text.
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT)
    -- font = love.graphics.setFont(32)
    -- font = love.graphics.newFont(100)
    -- love.graphics.setFont(font)--, 32)
end


function love.upate(dt)

end


function love.keypressed(key)
    if key == '`' then
        love.event.quit()
    end
end


function love.draw()

    -- text = WINDOW_WIDTH .. " x " .. WINDOW_HEIGHT
    -- tw = font:getWidth(text)
    -- th = font:getHeight(text)
    -- love.graphics.print(text, (WINDOW_WIDTH * 0.5) - (tw * 0.5), (WINDOW_HEIGHT * 0.5) - (th * 0.5))
    -- love.graphics.print("hello world")
    push:start()
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)
    --paddles
    love.graphics.rectangle('fill', player1.x, player1.y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', player2.x, player2.y, PADDLE_WIDTH, PADDLE_HEIGHT)
    --name
    cw = WINDOW_WIDTH * 0.5
    ch = WINDOW_HEIGHT * 0.5
    text = "PONG"
    -- tw = font:getWidth(text)
    -- th = font:getHeight(text)
    -- love.graphics.print(WINDOW_WIDTH .. " x " .. WINDOW_HEIGHT, cw - (tw * 0.5), ch - (th * 0.5))
    push:finish()
end