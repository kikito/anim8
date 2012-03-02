
local anim8 = require 'anim8'

function love.load()
  image = love.graphics.newImage('media/1945.png')

  local g32 = anim8.newGrid(32, 32, 1024, 768, 3, 3, 1)

  spinning = {
    anim8.newAnimation('loop',   g32('5-8,1', '1-2,1'), 0.1),

    anim8.newAnimation('bounce', g32('18,7-11'), 0.2),

    anim8.newAnimation('loop',   g32('5-8,2', '1-2,2'), 0.2),

    anim8.newAnimation('bounce', g32('19,7-11'), 0.2),

    anim8.newAnimation('loop',   g32('5-8,3', '1-2,3'), 0.3),

    anim8.newAnimation('bounce', g32('20,7-11'), 0.2),

    anim8.newAnimation('loop',   g32('5-8,4', '1-2,4'), 0.4),

    anim8.newAnimation('bounce', g32('21,7-11'), 0.2),

    anim8.newAnimation('loop',   g32('5-8,5', '1-2,5'), 0.5),

  }

  local g

end

function love.draw()
  for i=1,#spinning do
    spinning[i]:draw(image, i*75, i*50)
  end
end

function love.update(dt)
  for i=1,#spinning do
    spinning[i]:update(dt)
  end
end
