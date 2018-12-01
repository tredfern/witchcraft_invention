-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("components - inventory", function()
  local components = require "components"

  it("can pick up items and add them to the inventory", function()
    local inventory = components.inventory:new()
    local item = {}
    inventory:pick_up(item)
    assert.array_includes(item, inventory.items)
  end)

  it("can be checked if it contains an item", function()
    local inventory = components.inventory:new()
    local item = {}

    assert.is_false(inventory:contains(item))
    inventory:pick_up(item)
    assert.is_true(inventory:contains(item))
  end)

  it("can drop an item from the inventory", function()
    local inventory = components.inventory:new()
    local item = {}
    inventory:pick_up(item)

    assert.is_true(inventory:contains(item))
    inventory:drop(item)
    assert.is_false(inventory:contains(item))
  end)
end)
