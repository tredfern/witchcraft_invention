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
  local size = e.size or { width = 1, height = 1 }

  for x=0,size.width - 1 do
    for y=0,size.height - 1 do
      self.tiles:draw(e.symbol, e.position.x + x, e.position.y + y, e.color)
    end
  end
end

return RenderSymbolSystem
