-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("find_entity_helper", function()
  local tiny = require "ext.tiny-ecs"
  local components = require "components"
  local find_entity_helper = require "entities.find_entity_helper"

  it("can find an entities by position", function()
    local world = tiny.world()
    local e1 = {
      position = components.position:new(3, 5)
    }
    local e2 = {
      position = components.position:new(6, 4)
    }
    local e3 = {
      position = components.position:new(6, 4)
    }

    world:add(e1, e2, e3)
    world:refresh()

    assert.equals(0, #find_entity_helper:by_position(world.entities, 2, 5))

    assert.equals(1, #find_entity_helper:by_position(world.entities, 3, 5))
    assert.array_includes(e1, find_entity_helper:by_position(world.entities, 3, 5))

    assert.equals(2, #find_entity_helper:by_position(world.entities, 6, 4))
    assert.array_includes(e2, find_entity_helper:by_position(world.entities, 6, 4))
    assert.array_includes(e3, find_entity_helper:by_position(world.entities, 6, 4))
  end)

  it("can find entities by name", function()
    local world = tiny.world()
    local e1 = { name = "entity-one" }
    world:add(e1)
    world:refresh()
    assert.equals(1, #find_entity_helper:by_name(world.entities, "entity-one"))
    assert.equals(0, #find_entity_helper:by_name(world.entities, "entity-blah"))
    assert.array_includes(e1, find_entity_helper:by_name(world.entities, "entity-one"))
  end)
end)
