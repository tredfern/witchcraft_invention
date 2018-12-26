-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local List = require "ext.artemis.src.list"
local EntityTracker = tiny.system()
EntityTracker.filter = tiny.requireAny("entity_type")

EntityTracker.entity_types = {}

function EntityTracker:onAdd(e)
  if e.entity_type then
    self:track_entity_type(e)
  end
end


function EntityTracker:find_entity_type(entity_type)
  return self.entity_types[entity_type] or {}
end

function EntityTracker:track_entity_type(e)
  if not self.entity_types[e.entity_type] then
    self.entity_types[e.entity_type] = List:new()
  end
  self.entity_types[e.entity_type]:add(e)
end

return EntityTracker
