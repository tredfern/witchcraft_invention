-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local GuiDisplay = tiny.processingSystem()
GuiDisplay.is_draw_system = true
GuiDisplay.filter = tiny.requireAll("ui_display")

function GuiDisplay:preProcess()
  love.graphics.origin()
end

function GuiDisplay:process(entity)
  entity:draw()
end


return GuiDisplay
