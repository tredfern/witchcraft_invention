-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local settings = require "settings"
local Window = {
  ui_display = true,
  font = settings.ui_font,
  symbols = {
    topleft = "┌",
    topright = "┐",
    bottomleft = "└",
    bottomright = "┘",
    horizontal = "─",
    vertical = "│"
  },
  color = { 1, 1, 1, 1},
  background_color = { 0, 0, 0, 1},
  left = 1, top = 1, width = 10, height = 10
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
  love.graphics.rectangle("fill",
    (self.left - 1) * self.font.width, (self.top - 1) * self.font.height,
    self.width * self.font.width, self.height * self.font.height
  )

  self.font:draw(self.symbols.topleft, self.left, self.top, self.color)
  self.font:draw(self.symbols.topright, self.left + self.width, self.top, self.color)
  self.font:draw(self.symbols.bottomleft, self.left, self.top + self.height, self.color)
  self.font:draw(self.symbols.bottomright, self.left + self.width, self.top + self.height, self.color)

  for w=1,self.width - 1 do
    self.font:draw(self.symbols.horizontal, self.left + w, self.top, self.color)
    self.font:draw(self.symbols.horizontal, self.left + w, self.top + self.height, self.color)
  end

  for h=1,self.height - 1 do
    self.font:draw(self.symbols.vertical, self.left, self.top + h, self.color)
    self.font:draw(self.symbols.vertical, self.left + self.width, self.top + h, self.color)
  end

  if self.draw_interior then
    local l, t, w, h =
      self.left * self.font.width,
      self.top * self.font.height,
      (self.width - 1) * self.font.width,
      (self.height - 1) * self.font.height

    love.graphics.setScissor(l, t, w, h)
    love.graphics.push()
    love.graphics.translate(l, t)
    self:draw_interior()
    love.graphics.pop()
    love.graphics.setScissor()
  end
end

function Window:anchor_right()
  local sw = self.font:get_screen_tile_size()
  self.left = sw - self.width
end

function Window:anchor_bottom()
  local _, sh = self.font:get_screen_tile_size()
  self.top = sh - self.height
end

return Window
