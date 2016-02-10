local anim8 = require 'anim8'

local img = love.graphics.newImage('spritesheet.png')
img:setFilter('nearest')

local w,h = img:getDimensions()

local g = anim8.newGrid(16, 29, w, h, 0,0, 1)

local a1 = anim8.newAnimation(g('1-3',1, 2, 1), 0.1)
local a2 = a1:clone():flipH()
local a3 = a1:clone():flipV()
local a4 = a1:clone():flipH():flipV()

local kx, ky = 0,0

local batch = love.graphics.newSpriteBatch(img)

local id1 = batch:add(a1:getFrameInfo(200,100,0,4,4,0,0,kx,ky))
local id2 = batch:add(a1:getFrameInfo(500,100,0,4,4,0,0,kx,ky))
local id3 = batch:add(a1:getFrameInfo(200,300,0,4,4,0,0,kx,ky))
local id4 = batch:add(a1:getFrameInfo(500,300,0,4,4,0,0,kx,ky))

function love.draw()
  love.graphics.draw(batch, 0, 0)
  love.graphics.rectangle('line', 200,100, 16*4,29*4)
  love.graphics.rectangle('line', 500,100, 16*4,29*4)
  love.graphics.rectangle('line', 200,300, 16*4,29*4)
  love.graphics.rectangle('line', 500,300, 16*4,29*4)
  love.graphics.print(("kx=%f, ky=%f"):format(kx,ky), 20,20)
end

function love.update(dt)
  a1:update(dt)
  a2:update(dt)
  a3:update(dt)
  a4:update(dt)

  batch:set(id1, a1:getFrameInfo(200,100,0,4,4,0,0,kx,ky))
  batch:set(id2, a2:getFrameInfo(500,100,0,4,4,0,0,kx,ky))
  batch:set(id3, a3:getFrameInfo(200,300,0,4,4,0,0,kx,ky))
  batch:set(id4, a4:getFrameInfo(500,300,0,4,4,0,0,kx,ky))

  if love.keyboard.isDown('up')    then ky = ky - dt end
  if love.keyboard.isDown('down')  then ky = ky + dt end
  if love.keyboard.isDown('right') then kx = kx + dt end
  if love.keyboard.isDown('left')  then kx = kx - dt end
end

function love.keypressed(key)
  if key == 'escape' then love.event.quit() end
end
