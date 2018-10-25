-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local paths = require "paths"
local TextTiles = {}

function TextTiles:new(fontname, size)
  local tt = {
    size = size,
    font = love.graphics.newFont(paths.font_path .. fontname, size)
  }
  tt.width = tt.font:getWidth("A")
  tt.height = tt.font:getHeight("A")

  return tt
end

return TextTiles
