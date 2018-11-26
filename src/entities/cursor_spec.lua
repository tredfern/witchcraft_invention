-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Cursor", function()
  local cursor = require "entities.cursor"

  it("has a position for the cursor", function()
    local c = cursor:new(20, 30)
    assert.equals(20, c.position.x)
    assert.equals(30, c.position.y)
  end)
end)
