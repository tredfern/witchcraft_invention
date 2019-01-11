-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Fonts = require "graphics.fonts"
local Button = {}

function Button:new(title, callback)
  local Label = require "ui.label"

  local b = {
    label = Label:new(Fonts.button, title, 0, 0, {1,1,1,1}),
    click = function() callback() end
  }

  return b
end

return Button
