-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Tasks - Haul", function()
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
end)
