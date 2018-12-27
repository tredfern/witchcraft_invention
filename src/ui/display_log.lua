-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local reverse = require "ext.artemis.src.reverse_iterator"
local Window = require "ui.window"
local Logger = require "logger"
local DisplayLog = Window:new{
  left = 1,
  top = 1,
  width = 40,
  height = 20,
  background_color = { 0, 0, 0, 0.33 }
}

function DisplayLog:draw_interior()
  local h = 0
  for v in reverse(Logger.messages) do
    love.graphics.print(v, 0, h)
    h = h + self.font.height
  end
end

return DisplayLog
