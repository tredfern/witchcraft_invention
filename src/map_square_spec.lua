-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("MapSquare", function()
  local MapSquare = require "map_square"
  local terrain = require "terrain"

  it("requires a position", function()
    local ms = MapSquare:new(19, 39)
    assert.equals(19, ms.x)
    assert.equals(39, ms.y)
  end)

  it("initializes to none terrain", function()
    local ms = MapSquare:new(39, 49)
    assert.equals(terrain:none(), ms.terrain)
  end)
end)
