-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local position = require "components.position"

local character = {
  is_character = true,
  is_worker = true,
  symbol = "☺",
  color = { 0.75, 0.75, 0.75, 1},
  filter = tiny.requireAll("is_character", "position", "symbol", "color")
}

function character:new(x, y)
  local c = {
    position = position:new(x, y),
    speed = 0.2
  }
  setmetatable(c, self)
  self.__index = self
  return c
end

return character
