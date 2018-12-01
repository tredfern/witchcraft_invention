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

local function assigned_worker(w)
  return w.current_task ~= nil
end

function AssignTasks:update()
  self:check_for_completion()
  self:assign_tasks()
end

function AssignTasks:check_for_completion()
  local check_status = self.workers:where(assigned_worker)
  for _, w in ipairs(check_status) do
    if w.current_task.done then
      self.world:removeEntity(w.current_task)
      w.current_task = nil
    end
  end
end

function AssignTasks:assign_tasks()
  local check_status = self.workers:where(unassigned_worker)
  for _, w in ipairs(check_status) do
    local t = self.tasks:dequeue()
    if t then
      t:set_owner(w)
      w.current_task = t
    end
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
