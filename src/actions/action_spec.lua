-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Actions - action base", function()
  local action = require "actions.action"

  it("actions require a name", function()
    local no_name = { }
    assert.has_error(function() return action:new(no_name) end, "Action requires a name")
  end)

  it("can be marked as completed", function()
    local a = action:new({ name = "action" })
    a:finish()
    assert.is_true(a.done)
  end)
end)
