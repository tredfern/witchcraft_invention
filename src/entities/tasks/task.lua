-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Queue = require "ext.artemis.src.queue"
local Task = {
  is_task = true
}

function Task:new(tbl)
  local t = tbl
  t.action_queue = Queue:new()
  assert(t.name, "Task requires a name")
  setmetatable(t, self)
  self.__index = self
  return t
end

function Task:set_owner(owner)
  self.current_owner = owner
end

function Task:queue_action(action)
  self.action_queue:enqueue(action)
end

function Task:next_action()
  if not self.built_queue then
    self.built_queue = true
    self:build_action_queue()
  end

  if self.action_queue:isempty() then
    self.done = true
    if self.finish then
      self:finish()
    end
    return nil
  end

  return self.action_queue:dequeue()
end

return Task
