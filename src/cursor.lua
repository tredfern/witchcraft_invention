-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

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
  tt.default:draw(self.target.symbol, self.x, self.y, self.target.color)
end

return Cursor
