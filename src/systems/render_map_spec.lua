-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("RenderMap", function()
  require "test_helpers.mock_love"
  local tiny = require "ext.tiny-ecs"
  local terrain = require "terrain"

  it("draws the map by looping through each tile and drawing it (if it has terrain)", function()
    local world = tiny.world()
    local map = require "map":new(10, 10)
    map:set_terrain(3, 5, terrain:grass())
    world:addEntity(map)

    local drawCall = spy.new(function() end)
    local RenderMap = require "systems.render_map"
    RenderMap.tiles.draw = drawCall

    world:addSystem(RenderMap)
    world:refresh()
    world:update()

    assert.spy(drawCall).was.called()
  end)
end)
