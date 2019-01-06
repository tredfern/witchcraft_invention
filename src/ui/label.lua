-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Label = {}

function Label:new(font, text, x, y, color)
  local l = {
    font = font,
    text = text,
    x = x,
    y = y,
    color = color
  }
  setmetatable(l, self)
  self.__index = self
  l:create_canvas()
  return l
end

function Label:create_canvas()
  self.image = love.graphics.newCanvas(self.font:getWidth(self.text), self.font:getHeight())
  love.graphics.setCanvas(self.image)
  love.graphics.setFont(self.font)
  love.graphics.setColor(self.color)
  love.graphics.print(self.text, 0, 0)
  love.graphics.setCanvas(nil)
  love.graphics.reset()
end

function Label:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

return Label
