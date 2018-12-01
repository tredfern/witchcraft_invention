-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("GatherResources", function()
  local tiny = require "ext.tiny-ecs"
  local EntityFactory = require "systems.entity_factory"
  local GatherResources = require "systems.gather_resources"
  local WoodPile = require "entities.wood_pile"
  local world = tiny.world(GatherResources, EntityFactory)

  before_each(function()
    world:clearEntities()
    world:refresh()
  end)

  it("creates haul jobs for resources that are laying on the ground", function()
    local wp = WoodPile:new(32, 21)
    world:addEntity(wp)
    world:refresh()

    assert.equals(1, #world.entities)
    EntityFactory.create = spy.new(function() end)
    world:update()
    assert.equals(2, #world.entities)
  end)
end)
