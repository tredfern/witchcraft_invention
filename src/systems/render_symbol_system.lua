-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local RenderSymbolSystem = tiny.processingSystem()
local text_tiles = require "text_tiles"

RenderSymbolSystem.tiles = text_tiles:new("FreeMono.ttf", 24)
RenderSymbolSystem.filter = tiny.requireAll("position", "symbol", "color")

function RenderSymbolSystem:process(e, dt)
  self.tiles:draw(e.symbol, e.position.x, e.position.y, e.color) 
end

return RenderSymbolSystem
