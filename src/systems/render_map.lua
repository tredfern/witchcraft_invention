-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local settings = require "settings"
local RenderMap = tiny.system({})
RenderMap.tiles = settings.symbol_font
RenderMap.filter = tiny.requireAll("is_map")
RenderMap.is_draw_system = true


function RenderMap:update()
  for _, map in ipairs(self.entities) do
    self:draw_map(map)
  end
end

function RenderMap:draw_map(map)
  for x=1,map:get_width() do
    for y=1,map:get_height() do
      local t = map:get_terrain(x, y)
      if t.sprite then
        t.sprite:draw(x * settings.tile_width, y * settings.tile_height)
      end
    end
  end
end

return RenderMap
