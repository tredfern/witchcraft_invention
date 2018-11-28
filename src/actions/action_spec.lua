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
end)
