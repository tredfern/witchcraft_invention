-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Tasks - Haul", function()
  local systems = require "systems"
  local bag = require "ext.artemis.src.bag"
  local haul = require "entities.tasks.haul"
  local wood_pile = require "entities.wood_pile"
  local character = require "entities.character"

  it("tracks a resource to be hauled", function()
    local h = haul:new(wood_pile)
    assert.is_equal(wood_pile, h.target)
    assert.is_true(h.is_task)
  end)

  it("first order is to move to the location of the resource", function()
    local w = wood_pile:new(40, 21)
    local h = haul:new(w)
    local c = character:new(12, 9)
    h:set_owner(c)

    local action = h:next_action()
    assert.equals("move_to", action.name)
    assert.equals(40, action.target.x)
    assert.equals(21, action.target.y)
  end)

  it("after at location, the next action is to pick up the resources", function()
    local w = wood_pile:new(40, 21)
    local c = character:new(40, 21)
    local h = haul:new(w)
    h:set_owner(c)

    local action = h:next_action()
    assert.equals("pick_up", action.name)
    assert.equals(w, action.target)
  end)

  it("if the owner is carrying the item then it will start moving towards an available stockpile square", function()
    local stockpile = require "entities.stockpile":new(50, 50, 1, 1)
    systems.entity_tracker.find_entity_type = spy.new(function() return bag:new{stockpile} end)
    local w = wood_pile:new(40, 21)
    local c = character:new(40, 21)
    c.inventory:pick_up(w)
    local h = haul:new(w)
    h:set_owner(c)

    local action = h:next_action()
    assert.equals("move_to", action.name)
    assert.equals(stockpile.position, action.target)
    assert.spy(systems.entity_tracker.find_entity_type).was.called_with(systems.entity_tracker, stockpile.entity_type)
  end)

  it("tells the owner to drop the item when reaching the stockpile", function()
    local stockpile = require "entities.stockpile":new(40, 21, 1, 1)
    local w = wood_pile:new(40, 21)
    local c = character:new(40, 21)
    c.inventory:pick_up(w)
    local h = haul:new(w)
    h:set_owner(c)
    h.haul_to = stockpile

    local action = h:next_action()
    assert.equals("drop_item", action.name)
    assert.equals(w, action.target)

    -- make sure the notify function lets the stockpile know it has an item
    action.notify_dropped_on()
    assert.is_true(stockpile.storage:contains(w))
  end)

  it("if item is in haul_to stockpile then job is complete", function()
    local stockpile = require "entities.stockpile":new(40, 21, 1, 1)
    local w = wood_pile:new(40, 21)
    local c = character:new(40, 21)
    local h = haul:new(w)
    h:set_owner(c)
    h.haul_to = stockpile
    stockpile.storage:add(w)
    local action = h:next_action()
    assert.equals(nil, action)
    assert.is_true(h.done)
  end)
end)
