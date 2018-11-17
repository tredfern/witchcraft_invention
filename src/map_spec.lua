-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Map", function()
  local Map = require "src.map"
  local Terrain = require "terrain"

  it("Can track the terrain of various locations", function()
    local m = Map:new(100, 100)

    m:set_terrain(20, 30, Terrain:grass())
    assert.equals(Terrain:grass(), m:get_terrain(20, 30))
  end)

  it("knows it's width and height", function()
    local m = Map:new(482, 382)
    assert.equals(482, m:get_width())
    assert.equals(382, m:get_height())
  end)

  it("doesn't let you set terrain outside of bounds", function()
    local m = Map:new(30, 30)
    assert.has_no.errors(function() m:set_terrain(30, 30) end)
    assert.has.errors(function() m:set_terrain(31, 30) end)
  end)
end)
