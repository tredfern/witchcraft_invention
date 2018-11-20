-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local position = {}

function position:new(x, y)
  local p = {
    x = x or 1,
    y = y or 1
  }
  setmetatable(p, self)
  self.__index = self
  return p
end

function position:move(x, y)
  self.x, self.y = x, y
end

return position
