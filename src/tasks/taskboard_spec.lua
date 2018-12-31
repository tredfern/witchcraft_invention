-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Taskboard", function()
  local Taskboard = require "tasks.taskboard"

  before_each(function()
    Taskboard:clear()
  end)

  it("can clear the board of all tasks", function()
    Taskboard:post({}, {}, {})
    Taskboard:clear()
    assert.equals(0, #Taskboard.tasks)
  end)

  it("can post a task to the board", function()
    local task = {}
    Taskboard:post(task)
    assert.array.includes(task, Taskboard.tasks)
  end)

  it("can post multiple tasks in a single call", function()
    local t1, t2, t3 = {}, {}, {}
    Taskboard:post(t1, t2, t3)
    assert.array.includes(t1, Taskboard.tasks)
    assert.array.includes(t2, Taskboard.tasks)
    assert.array.includes(t3, Taskboard.tasks)
  end)

  it("can retrieve the next task from the board", function()
    local t1, t2, t3 = {}, {}, {}
    Taskboard:post(t1, t2, t3)
    assert.equals(t1, Taskboard:next())
    assert.equals(t2, Taskboard:next())
    assert.equals(t3, Taskboard:next())
  end)
end)
