-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Tasks - Haul", function()
  local systems = require "systems"
  local List = require "ext.artemis.src.list"
  local haul = require "tasks.haul"
  local wood_pile = require "entities.wood_pile"
  local character = require "entities.character"

  it("tracks a resource to be hauled", function()
    local h = haul:new(wood_pile)
    assert.is_equal(wood_pile, h.target)
    assert.is_true(h.is_task)
  end)

  describe("it's action queue", function()
    local stockpile = require "entities.stockpile":new(50, 50, 1, 1)
    systems.entity_tracker.find_entity_type = spy.new(function() return List:new{stockpile} end)
    local w = wood_pile:new(40, 21)
    local h = haul:new(w)
    local c = character:new(12, 9)
    h:set_owner(c)

    it("first moves to the target", function()
      local action = h:next_action()
      assert.equals("move_to", action.name)
      assert.equals(40, action.target.x)
      assert.equals(21, action.target.y)
    end)

    it("then picks up the target", function()
      local action = h:next_action()
      assert.equals("pick_up", action.name)
      assert.equals(w, action.target)
    end)

    it("then moves to the stockpile", function()
      local action = h:next_action()
      assert.equals("move_to", action.name)
      assert.equals(50, action.target.x)
      assert.equals(50, action.target.y)
    end)

    it("then drops the item in the stockpile", function()
      local action = h:next_action()
      assert.equals("drop_item", action.name)
      assert.equals(w, action.target)

      -- make sure the notify function lets the stockpile know it has an item
      action.notify_dropped_on()
      assert.is_true(stockpile.storage:contains(w))
    end)
  end)
end)
