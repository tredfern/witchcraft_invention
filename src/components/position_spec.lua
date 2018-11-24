-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("position", function()
  local position = require "components.position"
  it("initializes to {x=1, y=1} by default", function()
    local pos = position:new()
    assert.equals(1, pos.x)
    assert.equals(1, pos.y)
  end)

  it("can be initialized to a different position", function()
    local pos = position:new(4, 5)
    assert.equals(4, pos.x)
    assert.equals(5, pos.y)
  end)

  it("has a method to move to a different position", function()
    local pos = require "components.position":new(4, 5)
    pos:move_to(2, 3)
    assert.equals(2, pos.x)
    assert.equals(3, pos.y)
  end)
end)
