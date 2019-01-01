-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local queue = require "ext.artemis.src.queue"
local List = require "ext.artemis.src.list"
local Taskboard = require "tasks.taskboard"

local AssignTasks = tiny.system()

AssignTasks.filter = tiny.requireAll("is_worker")
AssignTasks.workers = List:new()

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
    local t = Taskboard:next()
    if t then
      t:set_owner(w)
      w.current_task = t
    end
  end
end

function AssignTasks:onAdd(entity)
  self.workers:add(entity)
end

function AssignTasks:onRemoveFromWorld()
  self.workers = List:new()
end

return AssignTasks
