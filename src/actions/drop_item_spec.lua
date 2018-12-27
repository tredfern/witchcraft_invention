-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Actions - DropItem", function()
  local Components = require "components"
  local DropItem = require "actions".drop_item
  local Character = require "entities.character"

  it("will remove the item from the inventory of the owner", function()
    local owner = Character:new(20, 59)
    local item = { position = Components.position:new(30, 21) }

    owner.inventory:pick_up(item)
    local di = DropItem:new(owner, item)

    assert.is_true(owner.inventory:contains(item))
    di:execute()
    assert.is_false(owner.inventory:contains(item))
  end)

  it("updates the position of the item to be the new location", function()
    local owner = Character:new(20, 59)
    local item = { position = Components.position:new(30, 21) }

    owner.inventory:pick_up(item)
    local di = DropItem:new(owner, item)

    di:execute()
    assert.equals(20, item.position.x)
    assert.equals(59, item.position.y)
    assert.is_true(di.done)
  end)

  it("executes the notify function when completed", function()
    local notify = spy.new(function() end)
    local owner = Character:new(20, 40)
    local item = { position = Components.position:new(30, 21) }
    owner.inventory:pick_up(item)
    local di = DropItem:new(owner, item, notify)
    di:execute()
    assert.spy(notify).was.called()
  end)
end)
