-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local settings = require "settings"
local Window = {
  ui_display = true,
  font = settings.ui_font,
  color = { 1, 1, 1, 1},
  background_color = { 0, 0, 0, 1},
  left = 0, top = 0, width = 100, height = 100
}

function Window:new(configuration)
  local win = configuration or {
    left = self.left,
    top = self.top,
    width = self.width,
    height = self.height }
  setmetatable(win, self)
  self.__index = self
  return win
end

function Window:draw()
  love.graphics.setColor(self.background_color)
  love.graphics.rectangle("fill", self.left, self.top, self.width, self.height)
  love.graphics.setColor(self.color)
  love.graphics.rectangle("line", self.left, self.top, self.width, self.height)

  if self.draw_interior then
    love.graphics.setScissor(self.left, self.top, self.width, self.height)
    love.graphics.push()
    love.graphics.translate(self.left, self.top)
    self:draw_interior()
    love.graphics.pop()
    love.graphics.setScissor()
  end
end

function Window:anchor_left()
  self.left = 0
end

function Window:anchor_top()
  self.top = 0
end

function Window:anchor_right()
  local sw = love.graphics.getWidth()
  self.left = sw - self.width
end

function Window:anchor_bottom()
  local sh = love.graphics.getHeight()
  self.top = sh - self.height
end

return Window
