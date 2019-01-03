-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "ext.class"
local Scene = class("Scene")

function Scene:activate()
  if Scene.current_scene then
    Scene.current_scene:deactivate()
  end
  Scene.current_scene = self
end

function Scene:deactivate()
end

function Scene:draw() end
function Scene:update() end
function Scene:keypressed() end

return Scene
