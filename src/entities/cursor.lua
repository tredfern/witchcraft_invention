-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local components = require "components"
local colors = require "colors"

local cursor = {
  name = "input-cursor",
  is_cursor = true,
  symbol = "X",
  color = colors.yellow
}

function cursor:new(x, y)
  local c = {
    position = components.position:new(x, y)
  }
  setmetatable(c, self)
  self.__index = self
  return c
end

return cursor
