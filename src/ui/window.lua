-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local utf8 = require "utf8"
local settings = require "ui.settings"
local Window = {
  font = settings.font,
  symbols = {
    topleft = utf8.char(0x250C), 
    topright = utf8.char(0x2510),
    bottomleft = utf8.char(0x2514),
    bottomright = utf8.char(0x2518),
    horizontal = utf8.char(0x2500),
    vertical = utf8.char(0x2502)
  }
}

function Window:new(x, y, w, h)
  local w = {
    x = x,
    y = y,
    width = w,
    height = h,
    color = {1,1,1,1}
  }
  setmetatable(w, self)
  self.__index = self
  return w
end

function Window:draw()
  self.font:draw(self.symbols.topleft, self.x, self.y, self.color)
  self.font:draw(self.symbols.topright, self.x + self.width, self.y, self.color)
  self.font:draw(self.symbols.bottomleft, self.x, self.y + self.height, self.color)
  self.font:draw(self.symbols.bottomright, self.x + self.width, self.y + self.height, self.color)

  for w=1,self.width - 1 do
    self.font:draw(self.symbols.horizontal, self.x + w, self.y, self.color)
    self.font:draw(self.symbols.horizontal, self.x + w, self.y + self.height, self.color)
  end

  for h=1,self.height - 1 do
    self.font:draw(self.symbols.vertical, self.x, self.y + h, self.color)
    self.font:draw(self.symbols.vertical, self.x + self.width, self.y + h, self.color)
  end
end

return Window
