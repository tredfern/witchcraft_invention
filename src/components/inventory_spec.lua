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
end)
