-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("size", function()
  local size = require "components.size"

  it("can be initialized with a width and height", function()
    local e = {}
    size:add(e, 12, 15)
    assert.equals(12, e.size.width)
    assert.equals(15, e.size.height)
  end)
end)
