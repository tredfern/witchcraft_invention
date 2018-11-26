-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local systems = require "systems"
local wood_pile = require "entities.wood_pile"
local choptree = {
  name = "chop_tree"
}

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
  systems.entity_factory:create(wood_pile:new(self.target.position.x, self.target.position.y))
  systems.entity_factory:remove(self.target)
  self.done = true
end

return choptree
