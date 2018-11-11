-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local randomly = require "randomly"
local Map = require "map"
local Terrain = require "terrain"
local MapGenerator = {}


function MapGenerator.seed(seed)
  MapGenerator.next_seed = seed or os.time()
  MapGenerator.set_seed = true
end

function MapGenerator.create(width, height)
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

  for lakes = 1, math.random(width * height / 100) do
    MapGenerator.create_lake(map)
  end

  for grassland = 1, math.random(width * height / 50) do
    MapGenerator.create_patch(map, Terrain:grass(), 5 + math.random(25))
  end

  return map
end

function MapGenerator.create_patch(map, terrain, size)
  local x, y = math.random(map:get_width()), math.random(map:get_height())

  for i=1,size do
    map:set_terrain(x, y, terrain)
    x = x + randomly.choose({-1, 0, 1})
    y = y + randomly.choose({-1, 0, 1})
  end
end

function MapGenerator.create_lake(map)
  MapGenerator.create_patch(map, Terrain:water(), 10 + math.random(100))
end

MapGenerator.seed()


return MapGenerator
