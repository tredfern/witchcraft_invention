-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actions = require "actions"
local chopwood = require "tasks.task":new{ name = "task.chopwood" }

function chopwood:new(tree)
  local c = {
    target = tree,
    done = false
  }
  setmetatable(c, self)
  self.__index = self
  return c
end

function chopwood:finish()
  self.target = nil
  self.done = true
end

function chopwood:build_action_queue()
  self:queue_action(actions.move_to:new(self.current_owner, self.target.position))
  self:queue_action(actions.chop_tree:new(self.current_owner, self.target))
end

return chopwood
