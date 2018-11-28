-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actions = require "actions"
local systems = require "systems"
local stockpile = require "entities.stockpile"

local haul = {
  is_task = true
}

function haul:new(target)
  local h = {
    target = target
  }
  setmetatable(h, self)
  self.__index = self
  return h
end

function haul:set_owner(owner)
  self.current_owner = owner
end

function haul:next_action()
  if self.current_owner then
    if not self.current_owner.position:same(self.target.position) then
      return actions.move_to:new(self.current_owner, self.target.position)
    else
      if not self.current_owner.inventory.items:contains(self.target) then
        return actions.pick_up:new(self.current_owner, self.target)
      else
        local haul_to = systems.entity_tracker:find_entity_type(stockpile.entity_type):first()
        return actions.move_to:new(self.current_owner, haul_to.position)
      end
    end
  end
end

return haul
