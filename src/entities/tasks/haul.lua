-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actions = require "actions"
local systems = require "systems"
local stockpile = require "entities.stockpile"

local haul = require "entities.tasks.task":new{ name = "tasks.haul" }

function haul:new(target)
  local h = {
    target = target
  }
  setmetatable(h, self)
  self.__index = self
  return h
end

function haul:next_action()
  if self.current_owner then
    local next_action = self:should_move_to_target()
    next_action = next_action or self:should_pick_up_target()
    next_action = next_action or self:should_move_to_stockpile()
    next_action = next_action or self:should_drop_target()
    self.done = next_action == nil
    return next_action
  end
end

function haul:should_move_to_target()
  if not self.current_owner.position:same(self.target.position) then
    return actions.move_to:new(self.current_owner, self.target.position)
  end
  return nil
end

function haul:should_pick_up_target()
  if not self.current_owner.inventory.items:contains(self.target) and not self.haul_to then
    return actions.pick_up:new(self.current_owner, self.target)
  end
  return nil
end

function haul:should_move_to_stockpile()
  if not self.haul_to then
    self.haul_to = systems.entity_tracker:find_entity_type(stockpile.entity_type):first()
    return actions.move_to:new(self.current_owner, self.haul_to.position)
  end
  return nil
end

function haul:should_drop_target()
  if not self.haul_to.storage:contains(self.target) then
    return actions.drop_item:new(self.current_owner, self.target, function() self.haul_to.storage:add(self.target) end)
  end
  return nil
end

return haul
