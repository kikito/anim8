package = "anim8"
version = "scm-1"
source = {
   url = "https://github.com/kikito/anim8/archive/v2.3.1.tar.gz"
}
description = {
   summary = "Animation library for [LÖVE](http://love2d.org).",
   detailed = "Animation library for [LÖVE](http://love2d.org).",
   homepage = "https://github.com/kikito/anim8",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.4"
}
build = {
   type = "builtin",
   modules = {
      anim8 = "anim8.lua",
      ["spec.anim8.animation_spec"] = "spec/anim8/animation_spec.lua",
      ["spec.anim8.grid_spec"] = "spec/anim8/grid_spec.lua",
      ["spec.love-mocks"] = "spec/love-mocks.lua"
   }
}
