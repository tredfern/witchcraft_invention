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

function haul:build_action_queue()
  self.haul_to = systems.entity_tracker:find_entity_type(stockpile.entity_type):first()

  self.action_queue:enqueue(actions.move_to:new(self.current_owner, self.target.position))
  self.action_queue:enqueue(actions.pick_up:new(self.current_owner, self.target))
  self.action_queue:enqueue(actions.move_to:new(self.current_owner, self.haul_to.position))
  self.action_queue:enqueue(
    actions.drop_item:new(self.current_owner, self.target, function() self.haul_to.storage:add(self.target) end)
  )
end

return haul
