-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local stockpile = {
  symbol = "#",
  color = require "colors".red
}

function stockpile:new(x, y, width, height)
  local s = {
    position = require "components.position":new(x, y),
    size = require "components.size":new(width, height)
  }
  setmetatable(s, self)
  self.__index = self
  return s
end

return stockpile
