-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local settings = require "settings"
local RenderSprites = tiny.processingSystem()
RenderSprites.filter = tiny.requireAll("position", "sprite")
RenderSprites.is_draw_system = true

function RenderSprites:process(entity)
  entity.sprite:draw(entity.position.x * settings.tile_width, entity.position.y * settings.tile_height)
end

return RenderSprites
