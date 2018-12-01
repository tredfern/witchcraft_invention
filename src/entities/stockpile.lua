-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "components"
local stockpile = {
  symbol = "#",
  color = require "colors".red
}

function stockpile:new(x, y, width, height)
  local s = {
    position = components.position:new(x, y),
    size = components.size:new(width, height),
    storage = components.storage:new()
  }
  setmetatable(s, self)
  self.__index = self
  return s
end

return stockpile
