-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local character = {}

function character:new(x, y)
  return {
    x = x,
    y = y,
    symbol = "☺",
    color = { 0.75, 0.75, 0.75, 1}
  }
end

return character
