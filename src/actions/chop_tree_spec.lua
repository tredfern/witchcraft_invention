-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("actions - chop_tree", function()
  local systems = require "systems"
  local actions = require "actions"
  local tree = require "entities.tree"
  local character = require "entities.character"
  local tiny = require "ext.tiny-ecs"
  tiny.world(systems.entity_factory)

  it("chopping a tree turns it into a pile of wood", function()
    systems.entity_factory.create = spy.new(function() end)
    systems.entity_factory.remove = spy.new(function() end)
    local t = tree:new(5, 5)
    local c = character:new(5, 5)
    local chop_tree = actions.chop_tree:new(c, t)

    chop_tree:execute(0.2)
    --somehow remove the old entity and replace with a new one representing wood
    assert.spy(systems.entity_factory.create).was.called()
    assert.spy(systems.entity_factory.remove).was.called_with(systems.entity_factory, t)
    assert.is_true(chop_tree.done)
  end)
end)
