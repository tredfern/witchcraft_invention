-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local queue = require "ext.artemis.src.queue"
local bag = require "ext.artemis.src.bag"

local AssignTasks = tiny.system()

AssignTasks.filter = tiny.requireAny("is_task", "is_worker")
AssignTasks.tasks = queue:new()
AssignTasks.workers = bag:new()

local function unassigned_worker(w)
  return w.current_task == nil
end

function AssignTasks:update()
  local w = self.workers:first(unassigned_worker)

  while w ~= nil and not self.tasks:isempty() do
    local t = self.tasks:dequeue()
    t.current_worker = w
    w.current_task = t
    w = self.workers:first(unassigned_worker)
  end
end

function AssignTasks:onAdd(entity)
  if entity.is_task then
    self.tasks:enqueue(entity)
  end

  if entity.is_worker then
    self.workers:add(entity)
  end
end

function AssignTasks:onRemoveFromWorld()
  self.tasks = queue:new()
  self.workers = bag:new()
end

return AssignTasks
