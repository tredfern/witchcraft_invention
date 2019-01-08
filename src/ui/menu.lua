-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Menu = {}
local List = require "ext.artemis.src.list"

function Menu:new(font, color)
  local Label = require "ui.label"
  assert(font, "Requires a font")
  assert(color, "Requires a text color")

  local m = {
    items = List:new(),
    x = 0,
    y = 0,
    spacing = 30,
    font = font,
    color = color,
    focused_item = 1,
    focus_indicator = Label:new(font, ">", 0, 0, color)
  }
  setmetatable(m, self)
  self.__index = self
  return m
end

function Menu:add_item(title, callback)
  local Label = require "ui.label"
  self.items:add({
    label = Label:new(self.font, title, self.x, self.y, self.color),
    title = title,
    callback = callback
  })
end

function Menu:get_focused_item()
  return self.items[self.focused_item]
end

function Menu:click()
  self:get_focused_item().callback()
end

function Menu:draw()
  local next_y = self.y
  for _, v in ipairs(self.items) do
    v.label.x = self.x
    v.label.y = next_y
    v.label:draw()
    next_y = next_y + self.spacing
  end

  self.focus_indicator.x = self.x - 15
  self.focus_indicator.y = self:get_focused_item().label.y
  self.focus_indicator:draw()
end

function Menu:next_item()
  self.focused_item = math.min(self.focused_item + 1, #self.items)
end

function Menu:previous_item()
  self.focused_item = math.max(self.focused_item -1, 1)
end

return Menu
