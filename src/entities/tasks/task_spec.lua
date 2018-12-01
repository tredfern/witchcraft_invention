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
end)
