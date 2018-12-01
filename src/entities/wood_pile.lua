-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local colors = require "colors"
local components = require "components"
local wood_pile = {
  symbol = "ʭ",
  color = colors.golden_brown,
  storable = true
}

function wood_pile:new(x, y)
  local wp = {
    position = components.position:new(x, y),
    wood = 100
  }
  setmetatable(wp, self)
  self.__index = self
  return wp
end

return wood_pile
