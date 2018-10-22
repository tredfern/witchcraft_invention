-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Terrain", function()
  local Terrain = require "terrain"
  it("has an image associated with the terrain type", function()
    local g = Terrain:grass()
    assert.not_equal(nil, g.image)
  end)

  it("returns the same terrain type after registering one", function()
    local g = Terrain:grass()
    local g2 = Terrain:grass()
    assert.equal(g, g2)
  end)
end)
