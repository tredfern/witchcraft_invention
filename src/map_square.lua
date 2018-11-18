-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local terrain = require "terrain"
local MapSquare = {}

function MapSquare:new(x, y)
  local ms = {
    x = x,
    y = y,
    terrain = terrain:none()
  }
  return ms
end

return MapSquare
