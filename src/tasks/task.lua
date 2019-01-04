-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "class"
local Logger = require "logger"
local Queue = require "ext.artemis.src.queue"
local Task = class("Task")

function Task:set_owner(owner)
  self.current_owner = owner
end

function Task:queue_action(action)
  self.action_queue:enqueue(action)
end

function Task:next_action()
  if not self.action_queue then
    self.action_queue = Queue:new()
    self:build_action_queue()
  end

  if self.action_queue:isempty() then
    self.done = true
    Logger.debug:log("Task Completed: %s", tostring(self))
    if self.finish then
      self:finish()
    end
    return nil
  end

  return self.action_queue:dequeue()
end

return Task
