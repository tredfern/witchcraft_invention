-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Task - Chop Wood", function()
  local chopwood = require "entities.tasks.chopwood"
  local tree = require "entities.tree"

  it("is flagged as a task", function()
    local t = tree:new(1, 1)
    local task = chopwood:new(t)
    assert.is_true(task.is_task)
  end)

  it("designates a tree to be chopped into wood", function()
    local t = tree:new(12, 39)
    local task = chopwood:new(t)
    assert.equals(t, task.target)
    assert.is_false(task.completed)
  end)

  it("when the task is done, the target is removed and flagged as completed", function()
    local t = tree:new(32, 32)
    local task = chopwood:new(t)
    task:done()
    assert.equals(nil, task.target)
    assert.is_true(task.completed)
  end)
end)
