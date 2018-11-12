-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("MapSquare", function()
  local MapSquare = require "map_square"
  
  it("can track the terrain for the square", function()
    local Terrain = require "terrain"
    local sq = MapSquare:new(5, 5)
    sq:set_terrain(Terrain:dirt())
    assert.equals(Terrain:dirt(), sq:get_terrain())
  end)

  it("tracks objects that are in the square", function()
    local sq = MapSquare:new(2, 3)
    sq:add("foo")
    sq:add("bar")
    assert.array_matches({"foo", "bar"}, sq:get_objects())
  end)
end)
