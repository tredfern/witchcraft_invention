-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("MapGenerator", function()
  local MapGenerator = require "map_generator"

  it("returns a randomly generated map of the specified size", function()
    local map = MapGenerator.create(100, 100)
    assert.equals(100, map:get_width())
    assert.equals(100, map:get_height())
    assert.not_equal(nil, map:get(26, 24))
  end)

  it("can be seeded to return the same map each time", function()
    MapGenerator.seed(1234)
    local map = MapGenerator.create(10, 10)
    MapGenerator.seed(1234)
    local map2 = MapGenerator.create(10, 10)

    for x=1,10 do
      for y=1,10 do
        assert.equals(map:get(x, y).name, map2:get(x, y).name)
      end
    end
  end)

  it("if no seed is set it should make different maps", function()
    local map = MapGenerator.create(50, 50)
    local map2 = MapGenerator.create(50, 50)

    local one_is_different = false
    for x=1,50 do
      for y=1,50 do
        one_is_different = one_is_different or map:get(x,y).name ~= map2:get(x, y).name
      end
    end
    assert.is_true(one_is_different)
  end)
end)
