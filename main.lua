
local anim8 = require 'anim8'

function love.load()
  image = love.graphics.newImage('media/1945.png')

  local g = anim8.newGrid(32, 32, 1024, 768, 1)

  animations = {
    anim8.newAnimation('loop', g('5-8,1', '1-2,1'), 0.1)
  }

end

function love.draw()
  animations[1]:draw(image, 100, 100)
end

function love.update(dt)
  animations[1]:update(dt)
end
