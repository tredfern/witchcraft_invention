-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local RenderSymbolSystem = tiny.processingSystem()
local settings = require "settings"

RenderSymbolSystem.tiles = settings.symbol_font
RenderSymbolSystem.filter = tiny.requireAll("position", "symbol", "color")

function RenderSymbolSystem:process(e, _)
  self.tiles:draw(e.symbol, e.position.x, e.position.y, e.color)
end

return RenderSymbolSystem
