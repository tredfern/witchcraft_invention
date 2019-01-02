-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("GatherResources", function()
  local tiny = require "ext.tiny-ecs"
  local Taskboard = require "tasks.taskboard"
  local GatherResources = require "systems.gather_resources"
  local WoodPile = require "entities.wood_pile"
  local world = tiny.world(GatherResources)

  before_each(function()
    world:clearEntities()
    world:refresh()
    Taskboard:clear()
  end)

  it("creates haul jobs for resources that are laying on the ground", function()
    local wp = WoodPile:new(32, 21)
    world:addEntity(wp)
    world:refresh()
    world:update()
    local haul = Taskboard:next()
    assert.equals(wp, haul.target)
  end)
end)
