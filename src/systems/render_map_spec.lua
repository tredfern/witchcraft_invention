-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("RenderMap", function()
  local tiny = require "ext.tiny-ecs"
  local terrain = require "terrain"
  local RenderMap = require "systems.render_map"

  it("is a drawing system", function()
    assert.is_true(RenderMap.is_draw_system)
  end)

  it("draws the map by looping through each tile and drawing it (if it has terrain)", function()
    local world = tiny.world()
    local map = require "map":new(10, 10)
    map:set_terrain(3, 5, terrain:grass())
    world:addEntity(map)

    local drawCall = spy.new(function() end)
    terrain:grass().sprite.draw = drawCall

    world:addSystem(RenderMap)
    world:refresh()
    world:update()

    assert.spy(drawCall).was.called()
  end)
end)
