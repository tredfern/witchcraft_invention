-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Scene = require "scenes.scene"
local LoadGame = Scene:subclass("LoadGame")

function LoadGame:draw()
  love.graphics.print("Load Game")
  love.graphics.print("Escape back to Title", 10, 10)
end

function LoadGame:keypressed(key)
  if key == "escape" then
    self:title()
  end
end

function LoadGame:title()
  require "scenes.title":new():activate()
end

return LoadGame
