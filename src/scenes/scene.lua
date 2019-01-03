-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "ext.class"
local Scene = class("Scene")

function Scene:activate()
  Scene.current_scene = self
end

return Scene
