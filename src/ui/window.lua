-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local settings = require "settings"
local Window = {
  font = settings.ui_font,
  symbols = {
    topleft = "┌",
    topright = "┐",
    bottomleft = "└",
    bottomright = "┘",
    horizontal = "─",
    vertical = "│"
  }
}

function Window:new(x, y, w, h, color)
  local win = {
    x = x,
    y = y,
    width = w,
    height = h,
    color = color or {1,1,1,1},
    background_color = {0,0,0,1}
  }
  setmetatable(win, self)
  self.__index = self
  return win
end

function Window:draw()
  love.graphics.setColor(self.background_color)
  love.graphics.rectangle("fill",
    (self.x - 1) * self.font.width, (self.y - 1) * self.font.height,
    self.width * self.font.width, self.height * self.font.height
  )

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
