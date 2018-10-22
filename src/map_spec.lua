-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Map", function()
  local Map = require "src.map"
  it("Can track the terrain of various locations", function()
    local m = Map:new(100, 100)

    m:set_terrain(20, 30, "grass")
    assert.equals("grass", m:get(20, 30))
  end)

end)
