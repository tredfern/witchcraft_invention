-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local paths = require "paths"
local TextTiles = {}

function TextTiles:new(fontname, size)
  local tt = {
    size = size,
    font = love.graphics.newFont(paths.font_path .. fontname, size)
  }
  tt.width = tt.font:getWidth("A")
  tt.height = tt.font:getHeight("A")
  self.__index = self
  setmetatable(tt, self)


  return tt
end

function TextTiles:get_box(x, y)
  return (x - 1) * self.width, (y - 1) * self.height, x * self.width, y * self.height
end

function TextTiles:draw(character, x, y, color)
  love.graphics.setFont(self.font)
  love.graphics.setColor(color)
  local sx, sy = self:get_box(x, y)
  love.graphics.print(character, sx, sy)
end

function TextTiles:new_tile(symbol, x, y, color)
  local t = {
    base = self,
    symbol = symbol,
    x = x,
    y = y,
    color = color,
    draw = function(self) 
      self.base:draw(self.symbol, self.x, self.y, self.color) 
    end
  }
  return t
end

return TextTiles
