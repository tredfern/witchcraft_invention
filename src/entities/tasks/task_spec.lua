-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Tasks - Base Task", function()
  local Task = require "entities.tasks.task"

  it("requires a name", function()
    local t = Task:new{name = "foo"}
    assert.equals("foo", t.name)
    local no_name = { }
    assert.has_error(function() return Task:new(no_name) end, "Task requires a name")
  end)

  it("has the ability to set the owner", function()
    local t = Task:new{name = "task"}
    local o = {}
    t:set_owner(o)
    assert.equals(o, t.current_owner)
  end)

  it("when getting next action will build an action queue that represents the actions to perform task", function()
    local a1, a2 = {}, {}
    local t = Task:new{name = "task",
      build_action_queue = function(self)
        self:queue_action(a1)
        self:queue_action(a2)
      end
    }
    local a = t:next_action()
    assert.equals(a1, a)
    assert.equals(a2, t.action_queue:front())
  end)

  it("when action queue is empty then the task is done", function()
    local a1, a2 = {}, {}
    local t = Task:new{name = "task",
      build_action_queue = function(self)
        self:queue_action(a1)
        self:queue_action(a2)
      end
    }
    t:next_action()
    t:next_action()
    t:next_action()
    assert.is_true(t.action_queue:isempty())
    assert.is_true(t.done)
  end)

  it("calls finish when task queue is empty to perform any finalization", function()
    local t = Task:new{ name = "task", build_action_queue = function() end }
    t.finish = spy.new(function() end)
    t:next_action()
    assert.spy(t.finish).was.called_with(t)
  end)
end)
