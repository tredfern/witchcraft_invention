-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local math_ext = require "ext.artemis.src.math_ext"
local randomly = require "randomly"
local Map = require "map"
local Terrain = require "terrain"
local tree = require "entities.tree"
local MapGenerator = {}


function MapGenerator.seed(seed)
  MapGenerator.next_seed = seed or os.time()
  MapGenerator.set_seed = true
end

function MapGenerator.create(width, height, world)
  if MapGenerator.set_seed then
    math.randomseed(MapGenerator.next_seed)
    MapGenerator.set_seed = false
  end

  local map = Map:new(width, height)

  for x=1,width do
    for y=1,height do
      map:set_terrain(x, y, Terrain:dirt())
    end
  end

  for _ = 1, math.random(math.floor(width * height / 100)) do
    MapGenerator.create_lake(map)
  end

  for _ = 1, math.random(math.floor(width * height / 50)) do
    MapGenerator.create_patch(map, Terrain:grass(), 5 + math.random(25))
  end

  for _ = 1, math.random(math.floor(width * height / 20)) do
    MapGenerator.create_forest(world, map)
  end

  world:refresh()
  return map
end

function MapGenerator.create_patch(map, terrain, size)
  local x, y = math.random(map:get_width()), math.random(map:get_height())

  for _=1,size do
    map:set_terrain(x, y, terrain)
    x = math_ext.clamp(x + randomly.choose({-1, 0, 1}), 1, map:get_width())
    y = math_ext.clamp(y + randomly.choose({-1, 0, 1}), 1, map:get_height())
  end
end

function MapGenerator.create_lake(map)
  MapGenerator.create_patch(map, Terrain:water(), 10 + math.random(100))
end

function MapGenerator.create_forest(world, map)
  local x, y = math.random(map:get_width()), math.random(map:get_height())
  local size = 40

  for _ = 1, size do
    if not tree.disallowed_terrains:contains(map:get_terrain(x, y)) then
      world:addEntity(tree:new(x, y))
    end
    x = math_ext.clamp(x + randomly.choose({-1, 0, 1}), 1, map:get_width())
    y = math_ext.clamp(y + randomly.choose({-1, 0, 1}), 1, map:get_height())
  end
end

MapGenerator.seed()
return MapGenerator
