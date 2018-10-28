-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local paths = require "paths"
local TextTiles = {}
local loaded_fonts = {}

function TextTiles:new(fontname, size)
  if loaded_fonts[fontname] and loaded_fonts[fontname][size] then
    return loaded_fonts[fontname][size]
  end
  local tt = {
    size = size,
    font = love.graphics.newFont(paths.font_path .. fontname, size)
  }
  tt.width = tt.font:getWidth("A")
  tt.height = tt.font:getHeight("A")
  self.__index = self
  setmetatable(tt, self)

  loaded_fonts[fontname] = loaded_fonts[fontname] or {}
  loaded_fonts[fontname][size] = tt

  return tt
end

function TextTiles:get_screen_tile_size()
  return love.graphics.getWidth() / self.width, love.graphics.getHeight() / self.height
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

function TextTiles:make_default()
  TextTiles.default = self
end

function TextTiles:new_tile(symbol, x, y, color)
  local t = {
    base = self,
    symbol = symbol,
    x = x,
    y = y,
    color = color,
    draw = function(slf)
      slf.base:draw(slf.symbol, slf.x, slf.y, slf.color)
    end
  }
  return t
end

TextTiles:new("FreeMono.ttf", 16):make_default()

return TextTiles
