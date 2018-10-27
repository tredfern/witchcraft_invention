-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local utf8 = require "utf8"

describe("Terrain", function()
  local Terrain = require "terrain"
  it("grass", function()
    local g = Terrain:grass()
    assert.equals(".", g.symbol)
  end)

  it("defines dirt", function()
    local d = Terrain:dirt()
    assert.equals(utf8.char(0x2058), d.symbol)
  end)

  it("returns the same terrain type after registering one", function()
    local g = Terrain:grass()
    local g2 = Terrain:grass()
    assert.equal(g, g2)
  end)

  it("can return a loaded terrain by name", function()
    local g = Terrain:grass()
    assert.equal(g, Terrain:get_terrain("grass"))
  end)
end)
