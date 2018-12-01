-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local EntityFactory = require "systems.entity_factory"
local GatherResources = tiny.system()
GatherResources.filter = tiny.requireAny("storable")

function GatherResources:onAdd(storable)
  local haul = require "entities.tasks.haul"
  EntityFactory:create(haul:new(storable))
end

return GatherResources
