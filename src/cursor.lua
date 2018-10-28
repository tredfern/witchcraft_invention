-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local utf8 = require "utf8"
local tt = require "text_tiles"
local Cursor = {
  x = 1,
  y = 1
}

Cursor.target = {
  symbol = "X",
  color = {1, 1, 0, 1}
}

function Cursor:draw()
  local sx, sy = tt.default:get_screen_tile_size()
  tt.default:draw(self.target.symbol, math.floor(sx / 2), math.floor(sy / 2), self.target.color)
end

return Cursor
