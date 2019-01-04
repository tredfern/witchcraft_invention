-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actions = require "actions"
local chopwood = require "tasks.task":subclass("task.chopwood")

function chopwood.__eq(a, b)
  return a.name == b.name and a.target == b.target
end

function chopwood:initialize(tree)
  self.target = tree
end

function chopwood:finish()
  self.target = nil
end

function chopwood:build_action_queue()
  self:queue_action(actions.move_to:new(self.current_owner, self.target.position))
  self:queue_action(actions.chop_tree:new(self.current_owner, self.target))
end

return chopwood
