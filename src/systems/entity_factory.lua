-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local EntityFactory = tiny.system()

function EntityFactory:create(entity)
  self.world:addEntity(entity)
end

function EntityFactory:remove(entity)
  self.world:removeEntity(entity)
  entity.is_removed = true
end

return EntityFactory
