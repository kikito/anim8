
local anim8 = require 'anim8'

function love.load()
  image = love.graphics.newImage('media/1945.png')

                         -- frame, image,    offsets, border
  local g32 = anim8.newGrid(32,32, 1024,768,   3,3,     1)

  spinning = {
                     -- type    -- frames                   --default delay
    anim8.newAnimation(g32('1-8',1),              0.1),
    anim8.newAnimation(g32(18,'8-11', 18,'10-7'), 0.2),
    anim8.newAnimation(g32('1-8',2),              0.3),
    anim8.newAnimation(g32(19,'8-11', 19,'10-7'), 0.4),
    anim8.newAnimation(g32('1-8',3),              0.5),
    anim8.newAnimation(g32(20,'8-11', 20,'10-7'), 0.6),
    anim8.newAnimation(g32('1-8',4),              0.7),
    anim8.newAnimation(g32(21,'8-11', 21,'10-7'), 0.8),
    anim8.newAnimation(g32('1-8',5),              0.9)
  }

                         -- frame, image,    offsets, border
  local g64 = anim8.newGrid(64,64, 1024,768,  299,101,   2)

  plane    = anim8.newAnimation(g64(1,'1-3'), 0.1)
  seaplane = anim8.newAnimation(g64('2-4',3), 0.1)
  seaplaneAngle = 0

                         -- frame, image,    offsets, border
  local gs = anim8.newGrid(32,98, 1024,768,  366,102,   1)

                                 -- type,  -- frames, d. delay, individual frame delays
  submarine = anim8.newAnimation(gs('1-7',1, '6-2',1), {2,['2-6']=0.1, [7]=1, ['8-12']=0.1})

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

function love.keypressed(key)
  if key == 'escape' then love.event.quit() end

  for i=1, #spinning do
    spinning[i]:flipH()
  end

  plane:flipV()
  seaplane:flipV(dt)
  submarine:flipV(dt)
end
