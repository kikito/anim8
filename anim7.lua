--[[
Copyright (c) 2012 Enrique García

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
]]

local Grid = {}


local function buildFrames(self)
  self._frames = {}
  local fw, fh = self.frameWidth, self.frameHeight
  local iw, ih = self.imageWidth, self.imageHeight
  local  w,  h = self.width, self.height

  for x = 1, w do
    self._frames[x] = {}
    for y = 1, h do
      self._frames[x][y] = love.graphics.newQuad((x-1)*fw, (y-1)*fh, fw, fh, iw, ih)
    end
  end
end

local function parseInterval(str)
  str = str:gsub(' ', '')
  local min, max = str:match("^(%d+)-(%d+)$")
  if not min then
    min = str:match("^%d+$")
    max = min
  end
  assert(min and max, ("Could not parse interval from %q"):format(str))
  return tonumber(min), tonumber(max)
end

local function parseIntervals(str)
  local left, right = str:match("(.+),(.+)")
  assert(left and right, ("Could not parse intervals from %q"):format(str))
  local minx, maxx = parseInterval(left)
  local miny, maxy = parseInterval(right)
  return minx, miny, maxx, maxy
end

local function getFrame(self, x, y)
  if not (self._frames[x] and self._frames[x][y]) then
    error("There is no frame for x=%q, y=%q"):format(tostring(x), tostring(y))
  end
  return self._frames[x][y]
end

local function parseFrames(self, args, result, position)
  local current = args[position]
  local kind = type(current)

  if kind == 'number' then

    result[#result + 1] = getFrame(self, current, args[position + 1])
    return position + 2

  elseif kind == 'string' then

    local minx, miny, maxx, maxy = parseIntervals(current)
    for x = minx, maxx do
      for y = miny, maxy do
        result[#result+1] = getFrame(self,x,y)
      end
    end

    return position + 1

  else

    error(("Invalid type: %q (%s)"):format(kind, tostring(args[position])))

  end
end


function Grid:getFrames(...)
  local args = {...}
  local length = #args
  local result = {}
  local position = 1

  while position <= length do
    position = parseFrames(self, args, result, position)
  end

  return result
end

local Gridmt = {
  __index = Grid,
  __call  = Grid.getFrames
}

local function newGrid(frameWidth, frameHeight, imageWidth, imageHeight)
  local grid = setmetatable(
    { frameWidth  = frameWidth,
      frameHeight = frameHeight,
      imageWidth  = imageWidth,
      imageHeight = imageHeight,
      width       = math.floor(imageWidth/frameWidth),
      height      = math.floor(imageHeight/frameHeight)
    },
    Gridmt
  )
  buildFrames(grid)
  return grid
end

-------------------------------------------------------

local animationModes = {
  loop   = function(self) self.position = 1 end,
  once   = function(self) self.position = #self.frames end,
  bounce = function(self)
    self.direction = self.direction * -1
    self.position = self.position + self.direction + self.direction
  end
}

local Animation = {}

function Animation:update(dt)
  if self.status ~= "playing" then return end

  self.timer = self.timer + dt

  while self.timer > self.delay do
    self.timer = self.timer - self.delay
    self.position = self.position + self.direction
    if self.position < 1 or self.position > #self.frames then
      self:padPosition()
    end
  end
end

function Animation:draw(image, x, y, angle, sx, sy, ox, oy)
  love.graphics.drawq(image, self.frames[self.position], x, y, angle, sx, sy, ox, oy)
end

function Animation:resume()
  self.status = "playing"
end

function Animation:pause()
  self.status = "paused"
end

function Animation:gotoFrame(frame)
  self.position = frame
  self.timer = 0
end

local Animationmt = { __index = Animation }

local function newAnimation(mode, delay, frames)
  assert(animationModes[mode], ("%q is not a valid mode"):format(tostring(mode)))
  assert(type(delay)=="number" and delay > 0, "delay must be a number greater than 0")
  return setmetatable({
      mode        = mode,
      delay       = delay,
      frames      = frames,
      padPosition = animationModes[mode],
      timer       = 0,
      position    = 1,
      direction   = 1,
      status      = "playing"
    },
    Animationmt
  )
end

-------------------------------------------------------

local anim8 = {
  newGrid = newGrid,
  newAnimation = newAnimation
}

return anim8
