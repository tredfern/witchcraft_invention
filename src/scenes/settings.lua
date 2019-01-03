-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Scene = require "scenes.scene"
local Settings = Scene:subclass("Settings")

function Settings:draw()
  love.graphics.print("Settings")
  love.graphics.print("Escape back to Title", 10, 10)
end

function Settings:keypressed(key)
  if key == "escape" then
    self:title()
  end
end

function Settings:title()
  require "scenes.title":new():activate()
end

return Settings
