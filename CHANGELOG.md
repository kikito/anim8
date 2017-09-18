anim8 changelog
===============

### v2.3.1

* Fixes bug where gotoFrame sometimes ended up on the wrong frame, which produced flickering (#19, #28)

### v2.3.0

* Adds support for shearing (kx, ky parameters when drawing)
* Adds Animation:getFrameInfo()

### v2.2.0

* Adds Animation:getDimensions()

### v2.1.0

* LÖVE version upped to 0.9.x

### v2.0.0

* Replaced `mode` parameter by `onLoop` and `pauseAtEnd`.
* `delays` and `defaultDelays` are merged into a single parameter: `durations`.
* `flipH` and `flipV` return a new animation.
* Interval parsing simplified. Old: '1-2,3'. New: '1-2',3
