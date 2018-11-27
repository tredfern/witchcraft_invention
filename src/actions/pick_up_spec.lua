-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("actions - pick up", function()
  local character = require "entities.character"
  local actions = require "actions"

  it("will take an item and assign it to the owner's carry slot", function()
    local c = character:new(20, 20)
    local item = {}
    local pickup = actions.pick_up:new(c, item)
    pickup:execute()
    assert.array_includes(item, c.inventory.items)
    assert.is_true(pickup.done)
  end)
end)
