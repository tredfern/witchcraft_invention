-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local systems = require "systems"
local wood_pile = require "entities.wood_pile"
local choptree = require "actions.action":new({ name = "chop_tree"})

function choptree:new(owner, tree)
  local ct = {
    owner = owner,
    target = tree
  }
  setmetatable(ct, self)
  self.__index = self
  return ct
end

function choptree:execute()
  local wp = wood_pile:new(self.target.position.x, self.target.position.y)
  systems.entity_factory:create(wp)
  systems.entity_factory:remove(self.target)
  self:finish()
end

return choptree
