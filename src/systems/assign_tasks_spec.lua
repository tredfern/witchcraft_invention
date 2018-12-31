-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("System - Assign Tasks ", function()
  local AssignTasks = require "systems.assign_tasks"
  local world = require "ext.tiny-ecs".world()
  local Task = require "tasks.task"

  before_each(function()
    world:clearEntities()
    world:clearSystems()
    world:refresh()

    world:addSystem(AssignTasks)
    world:refresh()
  end)

  it("is an updates system", function()
    assert.is.falsy(AssignTasks.is_draw_system)
  end)

  it("clears out all tasks and entities when removed from world", function()
    local task = Task:new{ name = "foo" }
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
    local task = Task:new{ name = "foo" }
    local worker = { is_worker = true }
    world:add(task, worker)

    world:refresh()
    AssignTasks:update()

    assert.equals(worker, task.current_owner)
    assert.equals(task, worker.current_task)
  end)

  it("it only assigns tasks if the worker does not already have a task", function()
    local task1 = Task:new{ name = "foo" }
    local task2 = Task:new{ name = "foo2" }
    local worker = { is_worker = true }
    world:add(task1, task2, worker)
    world:refresh()
    AssignTasks:update()
    AssignTasks:update()

    assert.equals(worker, task1.current_owner)
    assert.equals(task1, worker.current_task)
    assert.equals(nil, task2.current_owner)
  end)

  it("if no tasks then do nothing", function()
    local worker = { is_worker = true }
    world:add(worker)
    world:refresh()
    AssignTasks:update()
    assert.equals(nil, worker.current_task)
  end)

  it("removes a task if it is done and clears the worker so it's free to work on another task", function()
    local worker = { is_worker = true }
    local task1 = Task:new{ name = "foo" }
    world:add(task1, worker)
    world:refresh()
    AssignTasks:update()
    task1.done = true
    AssignTasks:update()
    world:refresh()
    assert.equals(nil, worker.current_task)
    assert.is_not.array_includes(task1, world.entities)
  end)
end)
