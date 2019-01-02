-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local Taskboard = require "tasks.taskboard"
local GatherResources = tiny.system()
GatherResources.filter = tiny.requireAny("storable")

function GatherResources:onAdd(storable)
  local Haul = require "tasks.haul"
  Taskboard:post(Haul:new(storable))
end

return GatherResources
