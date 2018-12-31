-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Sprites = require "graphics.sprites"
local components = require "components"
local stockpile = {
  entity_type = "stockpile"
}

function stockpile:new(x, y, width, height)
  local s = {
    position = components.position:new(x, y),
    size = components.size:new(width, height),
    storage = components.storage:new(),
    sprite = Sprites.stockpile()
  }
  setmetatable(s, self)
  self.__index = self
  return s
end

return stockpile
