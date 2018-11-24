-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("System - Assign Tasks ", function()
  local AssignTasks = require "systems.assign_tasks"
  local world = require "ext.tiny-ecs".world()

  before_each(function()
    world:clearEntities()
    world:clearSystems()
    world:refresh()

    world:addSystem(AssignTasks)
    world:refresh()
  end)

  it("clears out all tasks and entities when removed from world", function()
    local task = { is_task = true }
    local worker = { is_worker = true }
    world:add(task, worker)
    world:refresh()

    assert.array_includes(task, AssignTasks.tasks)
    assert.array_includes(worker, AssignTasks.workers)

    world:removeSystem(AssignTasks)
    world:refresh()
    assert.empty_array(AssignTasks.tasks)
    assert.empty_array(AssignTasks.workers)
  end)

  it("takes any task entities that are unassigned and finds a suitable worker", function()
    local task = { is_task = true }
    local worker = { is_worker = true }
    world:add(task, worker)

    world:refresh()
    AssignTasks:update()

    assert.equals(worker, task.current_worker)
    assert.equals(task, worker.current_task)
  end)

  it("it only assigns tasks if the worker does not already have a task", function()
    local task1 = { is_task = true }
    local task2 = { is_task = true }
    local worker = { is_worker = true }
    world:add(task1, task2, worker)
    world:refresh()
    AssignTasks:update()
    AssignTasks:update()

    assert.equals(worker, task1.current_worker)
    assert.equals(task1, worker.current_task)
    assert.equals(nil, task2.current_worker)
  end)

  it("if no tasks then do nothing", function()
    local worker = { is_worker = true }
    world:add(worker)
    world:refresh()
    AssignTasks:update()
    assert.equals(nil, worker.current_task)
  end)
end)
