-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("MapGenerator", function()
  local tiny = require "ext.tiny-ecs"
  local tree = require "entities.tree"
  local terrain = require "terrain"
  local world = tiny.world()
  local MapGenerator = require "map_generator"

  before_each(function()
    tiny.clearEntities(world)
    tiny.clearSystems(world)
  end)

  it("returns a randomly generated map of the specified size", function()
    local map = MapGenerator.create(12, 12, world)
    assert.equals(12, map:get_width())
    assert.equals(12, map:get_height())
    assert.not_equal(nil, map:get(6, 4))
  end)

  it("can be seeded to return the same map each time", function()
    MapGenerator.seed(1234)
    local map = MapGenerator.create(10, 10, world)
    MapGenerator.seed(1234)
    local map2 = MapGenerator.create(10, 10, world)

    for x=1,10 do
      for y=1,10 do
        assert.equals(map:get(x, y).name, map2:get(x, y).name)
      end
    end
  end)

  it("if no seed is set it should make different maps", function()
    local size = 20
    local map = MapGenerator.create(size, size, world)
    local map2 = MapGenerator.create(size, size, world)

    local one_is_different = false
    for x=1,size do
      for y=1,size do
        one_is_different = one_is_different or map:get_terrain(x,y) ~= map2:get_terrain(x, y)
      end
    end
    assert.is_true(one_is_different)
  end)

  it("adds trees to terrain that is not water", function()
    local map = MapGenerator.create(50, 50, world)

    -- loop through tree entities and make sure their location does not include water
    local tree_system = tiny.system({
      filter = tree.filter,
      update = spy.new(function(system)
        for _, e in ipairs(system.entities) do
          assert.is_true(e.is_tree)
          assert.not_equal(terrain:water(), map:get_terrain(e.position.x, e.position.y))
        end
      end)
    })
    world:addSystem(tree_system)
    world:refresh()
    world:update()
    assert.spy(tree_system.update).was_called()
  end)
end)
