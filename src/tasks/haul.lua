-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actions = require "actions"
local systems = require "systems"
local stockpile = require "entities.stockpile"

local haul = require "tasks.task":subclass("task.haul")

function haul:initialize(target)
  self.target = target
end

function haul:build_action_queue()
  self.haul_to = systems.entity_tracker:find_entity_type(stockpile.entity_type):first()

  self:queue_action(actions.move_to:new(self.current_owner, self.target.position))
  self:queue_action(actions.pick_up:new(self.current_owner, self.target))
  self:queue_action(actions.move_to:new(self.current_owner, self.haul_to.position))
  self:queue_action(
    actions.drop_item:new(self.current_owner, self.target, function() self.haul_to.storage:add(self.target) end)
  )
end

return haul
