-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("components", function()
  local components = require "components"

  it("has a position component it can use", function()
    local p = components.position:new(3, 3)
    assert.equals(3, p.x)
    assert.equals(3, p.y)
  end)

  it("has a size component", function()
    assert.not_equal(nil, components.size)
  end)
end)
