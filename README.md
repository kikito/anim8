anim8
=====

Animation library for [LÖVE](http://love2d.org).

[![Build Status](https://travis-ci.org/kikito/anim8.png?branch=master)](https://travis-ci.org/kikito/anim8)

It divides animations into two parts: grids and animations.

`anim8.newGrid(frameWidth, frameHeight, imageWidth, imageHeight, left, top, border)`:

Creates a *Grid*. Grids are useful for quickly defining frames (in LÖVE terminology, they are called *Quads*. The last 3 parameters are optional.

`anim8.newAnimation(mode, frames, defaultDelay, delays, flippedH, flippedV)`:

Creates a new *Animation*. Animations can be updated and drawn (they need a target image to do that). `delays`2 is optional, `flippedH` and `flippedV` are optional.

Example
=======

```
local anim8 = require 'anim8'

local image, animation

function love.load()
  image = love.graphics.newImage('path/to/image.png')
  local g = anim8.newGrid(32, 32, image:getWidth(), image:getHeight())
  animation = anim8.newAnimation('loop', g('1-8,1'), 0.1)
end

function love.update(dt)
  animation:update(dt)
end

function love.draw()
  animation:draw(image, 100, 200)
end
```

Explanation
===========

Grids
-----

Grids have only one purpose: To build groups of quads of the same size as easily as possible. In order to do this, they need to know only 2 things: the size of each quad and the size of the image they will be applied two. Each size is a width and a height, and those are the first 4 parameters of @anim8.newGrid@.

Grids are just a convenient way of getting frames from a sprite. Frames are assumed to be distributed in rows and columns. Frame 1,1 is the one in the first row, first column.

The last 3 parameters of newGrid default to 0. They are called `left`, `right` & `border`. They allow you to handle those cases in which the frames start slightly up or left, or have "borders" that must be ignored.

Grids only have one important method: `Grid:getFrames(...)`.

`Grid:getFrames` accepts an arbitrary number of parameters. They can be either numbers or strings.

* Each two numbers are interpreted as quad coordinates. This way, `grid:getFrames(3,4)` will return the frame in column 3, row 4 of the grid. There can be more than just two: `grid:getFrames(1,1, 1,2, 1,3)` will return the frames in {1,1}, {1,2} and {1,3} respectively.
* Using numbers for long rows is tedious - so grids also accept strings. The previous row of 3 elements, for example, can be also expressed like this: `grid:getFrames('1,1-3')` . Again, there can be more than one string (`grid:getFrames('1,1-3', '2-4,3')`) and it's also possible to combine them with numbers (`grid:getFrames(1,4, '1,1-3')`)

But you will probably never use getFrames directly. You can use a grid as if it was a function, and getFrames will be called. In other words, given a grid called `g`, this:

    g:getFrames('2-8,1', 1,2)

Is equivalent to this:

    g('2-8,1', 1,2)

This is very convenient to use in animations.

Animations
----------

Animations are groups of frames that are interchanged every now and then.

`anim8.newAnimation(mode, frames, defaultDelay, delays, flippedH, flippedV)`:

`mode` can have three different values:

* `"loop"` is the most used one. Once an animation reaches the last frame, it starts with the first one again.
* `"once"`: the animation that gets repeated only once, and then stays on the last frame forever (or until reset).
* `"bounce"`: when the animation reaches the last frame, it starts "going backwards" until it reaches the first frame again, and then "goes forward" again.


`frames` is an array of frames (Quads in LÖVE argot). You could provide your own quad array if you wanted to, but using a grid to get them is very convenient.

`defaultDelay` is the amount of time that the animation must spend on each frame, unless given other orders. It must be a positive number.

`delays` is an optional parameter. It specifies individual delays for frames. You can specify delays for all frames, like this: `{0.1, 0.5, 0.1}` or you can specify delays only for some frames, and leave the rest by default: `{[2]=0.5}`. Finally, you can also use strings to denote ranges: `{['3-5']=0.2}`.

`flippedH` and `flippedV` will make the animation horizontally or vertically flipped if set to true. This can be changed later on by using the `flipH` and `flipV` methods. The quads that conform the animation are not affected by this change; it only affects the way they are drawn on this particular animation, not globally.

Animations have the following methods:

`Animation:update(dt)`

Use this inside `love.update(dt)` so that your animation changes frames according to the time that has passed.

`Animation:draw(image, x,y, angle, sx, sy, ox, oy)`

Draws the current frame in the specified coordinates with the right angle, scale and offset. These parameters work exacly the same way as in "love.graphics.drawq":https://love2d.org/wiki/love.graphics.drawq .

`Animation:gotoFrame(frame)`

Moves the animation to a given frame (frames start counting in 1).

`Animation:pause()`

Stops the animation from updating (@animation:update(dt)@ will have no effect)

`Animation:resume()`

Unpauses an animation

`Animation:clone()`

Creates a new animation identical to the current one. The only difference is that its internal counter is reset to 0 (it's on the first frame).

`Animation:flipH()`

Flips an animation horizontally (left goes to right and viceversa). This means that the frames are simply drawn differently, nothing more.

Note that this method does not create a new animation. If you want to create a new one, use the @clone@ method.

`Animation:flipV()`

Flips an animation vertically. The same rules that apply to @flipH@ also apply here.


Installation
============

Just copy the anim8.lua file wherever you want it. Then require it wherever you need it:

    local anim8 = require 'anim8'

Please make sure that you read the license, too (for your convenience it's included at the beginning of the anim8.lua file).

Specs
=====

This project uses "busted":http://olivinelabs.com/busted/ for its specs. If you want to run the specs, you will have to install it first. Then just execute the following from the root folder:

    busted

