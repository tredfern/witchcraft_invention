-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

-- These tests are focused around verifying usage patterns
-- of tiny-ecs outside of the other tests that will eventually
-- need them. It's a bed to understand the library more than anything
--
-- DISCOVERIES
-- 1. Worlds need to be refreshed after adding/removing systems or entities
-- 2. Processing Systems will only be called if they have entities that match their filter
-- 3. A filter is required on a system for any entities to show up and it must have values to filter on

describe("tiny-ecs", function()
  local tiny = require "ext.tiny-ecs"

  it("has filter functions that filter on properties and works with metatables", function()
    local f1 = tiny.requireAll("position", "shape", "color")
    local f2 = tiny.requireAny("position", "shape", "color")

    local e1 = { position = true, shape = true, color = true }
    local e2 = { shape = true }
    local e3 = {}

    assert.is_true(f1(nil, e1))
    assert.is_false(f1(nil, e2))
    assert.is_false(f1(nil, e3))
    assert.is_true(f2(nil, e1))
    assert.is_true(f2(nil, e2))
    assert.is_false(f2(nil, e3))

    setmetatable(e3, e1)
    e1.__index = e1
    assert.is_true(f1(nil, e3))
    assert.is_true(f2(nil, e3))
  end)

  it("has a world that can have entities added and removed to it", function()
    local world = tiny.world()

    local e1 = {}
    local e2 = {}
    local e3 = {}

    tiny.addEntity(world, e1)
    tiny.add(world, e2, e3)
    world:refresh()
    assert.equals(3, tiny.getEntityCount(world))
    tiny.removeEntity(world, e2)

    world:refresh()
    assert.equals(2, tiny.getEntityCount(world))
  end)

  it("what happens when we remove an entity that does not exist in world?", function()
    local world = tiny.world()
    tiny.removeEntity(world, {}) -- no error
    tiny.update(world)
  end)

  it("can have systems that we can use to do interesting things", function()
    local world = tiny.world()
    local e1 = { foo = true }
    local processing_system = tiny.processingSystem({
      process = spy.new(function() end), filter = tiny.requireAny("foo")
    })
    local general_system = tiny.system({ update = spy.new(function() end) })

    world:addSystem(processing_system)
    world:addSystem(general_system)
    world:addEntity(e1)
    world:refresh()
    assert.is_true(processing_system.active)
    assert.is_true(general_system.active)

    world:update(10)
    assert.spy(general_system.update).was_called()
    assert.spy(processing_system.process).was_called()
    -- processing systems will only be called process with entities that match
  end)

  it("do systems without filter see all or no entities?", function()
    local world = tiny.world()
    local e1 = { component = true }
    local system = tiny.system({update = spy.new(function(self) return #self.entities end)})
    system.filter = tiny.requireAny("component")
    world:addSystem(system)
    world:addEntity(e1)
    world:refresh()
    world:update()
    assert.spy(system.update).was_called()
    assert.equals(1, #system.entities)
  end)
end)
