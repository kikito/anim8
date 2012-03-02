
local anim8 = require 'anim8'

function love.load()
  image = love.graphics.newImage('media/1945.png')

                         -- frame, image,    offsets, border
  local g32 = anim8.newGrid(32,32, 1024,768,   3,3,     1)

  spinning = {
                     -- type    -- frames                   --default delay
    anim8.newAnimation('loop',   g32('1-8,1'),   0.1),
    anim8.newAnimation('bounce', g32('18,7-11'), 0.2),
    anim8.newAnimation('loop',   g32('1-8,2'),   0.3),
    anim8.newAnimation('bounce', g32('19,7-11'), 0.4),
    anim8.newAnimation('loop',   g32('1-8,3'),   0.5),
    anim8.newAnimation('bounce', g32('20,7-11'), 0.6),
    anim8.newAnimation('loop',   g32('1-8,4'),   0.7),
    anim8.newAnimation('bounce', g32('21,7-11'), 0.8),
    anim8.newAnimation('loop',   g32('1-8,5'),   0.9)

  }

                         -- frame, image,    offsets, border
  local g64 = anim8.newGrid(64,64, 1024,768,  299,101,   2)

  plane    = anim8.newAnimation('loop', g64('1,1-3'), 0.1)
  seaplane = anim8.newAnimation('loop', g64('2-4,3'), 0.1)
  seaplaneAngle = 0

                         -- frame, image,    offsets, border
  local gs = anim8.newGrid(32,98, 1024,768,  366,102,   1)

                                 -- type,  -- frames, d. delay, individual frame delays
  submarine = anim8.newAnimation('bounce', gs('1-7,1'),   0.1,  {2,[7]=1})


end

function love.draw()
  for i=1,#spinning do
    spinning[i]:draw(image, i*75, i*50)
  end
  plane:draw(   image, 100, 400)
  seaplane:draw(image, 250, 432, seaplaneAngle, 1, 1, 32, 32)
  submarine:draw(image, 600, 100)

end

function love.update(dt)
  for i=1,#spinning do
    spinning[i]:update(dt)
  end
  plane:update(dt)
  seaplane:update(dt)
  submarine:update(dt)

  seaplaneAngle = seaplaneAngle + dt
end
