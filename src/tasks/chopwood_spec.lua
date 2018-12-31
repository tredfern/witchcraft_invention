-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Task - Chop Wood", function()
  local chopwood = require "tasks.chopwood"
  local tree = require "entities.tree"
  local character = require "entities.character"

  it("is flagged as a task", function()
    local t = tree:new(1, 1)
    local task = chopwood:new(t)
    assert.is_true(task.is_task)
  end)

  it("designates a tree to be chopped into wood", function()
    local t = tree:new(12, 39)
    local task = chopwood:new(t)
    assert.equals(t, task.target)
    assert.is_false(task.done)
  end)

  it("when the task is done, the target is removed and flagged as completed", function()
    local t = tree:new(32, 32)
    local task = chopwood:new(t)
    task:finish()
    assert.equals(nil, task.target)
    assert.is_true(task.done)
  end)

  describe("it's action queue", function()
    local target = tree:new(12, 39)
    local task = chopwood:new(target)
    local worker = character:new(20, 20)
    task:set_owner(worker)

    it("to perform the task, it first needs to move the character to the location", function()
      local action = task:next_action()
      assert.equals("move_to", action.name)
      assert.equals(worker, action.owner)
      assert.equals(12, action.target.x)
      assert.equals(39, action.target.y)
    end)

    it("then chops the tree", function()
      local action = task:next_action()
      assert.equals("chop_tree", action.name)
      assert.equals(worker, action.owner)
      assert.equals(target, action.target)
    end)

    it("after the tree is gone then the task is done", function()
      task:next_action()
      assert.is_true(task.done)
    end)
  end)
end)
