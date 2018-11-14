-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tree = {}

function tree:new(x, y)
  return {
    x = x,
    y = y,
    symbol = "♠",
    color = {0,0.75, 0, 1}
  }
end

return tree
