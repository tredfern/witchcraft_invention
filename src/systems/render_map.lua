-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local TextTiles = require "text_tiles"
local RenderMap = tiny.system({})
RenderMap.tiles = TextTiles:new("FreeMono.ttf", 24)
RenderMap.filter = tiny.requireAll("is_map")


function RenderMap:update()
  for _, map in ipairs(self.entities) do
    self:draw_map(map)
  end
end

function RenderMap:draw_map(map)
  for x=1,map:get_width() do
    for y=1,map:get_height() do
      local t = map:get_terrain(x, y)
      if t then
        self.tiles:draw(t.symbol, x, y, t.color)
      end
    end
  end
end

return RenderMap
