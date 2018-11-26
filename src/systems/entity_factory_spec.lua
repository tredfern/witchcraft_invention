-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("systems - Entity Factory", function()
  local systems = require "systems"
  local tiny = require "ext.tiny-ecs"
  local world = tiny.world()

  before_each(function()
    world:clearEntities()
    world:clearSystems()
    world:refresh()
    world:addSystem(systems.entity_factory)
    world:refresh()
  end)

  it("will register entities with the world", function()
    local e = {}
    systems.entity_factory:create(e)
    world:refresh()
    assert.array_includes(e, world.entities)
  end)

  it("can remove an entity", function()
    local e = {}
    systems.entity_factory:create(e)
    world:refresh()
    systems.entity_factory:remove(e)
    world:refresh()
    assert.does_not.array_includes(e, world.entities)
    assert.is_true(e.is_removed)
  end)
end)
