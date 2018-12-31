-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Taskboard = {}
local Queue = require "ext.artemis.src.queue"
Taskboard.tasks = Queue:new()

function Taskboard:post(...)
  for _, v in ipairs({...}) do
    self.tasks:enqueue(v)
  end
end

function Taskboard:next()
  return self.tasks:dequeue()
end

function Taskboard:clear()
  self.tasks:clear()
end

return Taskboard
