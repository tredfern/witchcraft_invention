-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Map = {
  is_map = true
}
local Grid = require "ext.artemis.src.grid"
local MapSquare = require "map_square"

function Map:new(width, height)
  local m = {
    grid = Grid:new(width, height)
  }
  self.__index = self
  setmetatable(m, self)
  m:initialize_map()
  return m
end

function Map:initialize_map()
  for x=1,self:get_width() do
    for y=1,self:get_height() do
      self.grid:set(x, y, MapSquare:new(x, y))
    end
  end
end

function Map:set_terrain(x, y, terrain)
  self:get(x, y).terrain = terrain
end

function Map:get_terrain(x, y)
  return self:get(x,y).terrain
end

function Map:get(x, y)
  return self.grid:get(x, y)
end

function Map:get_width()
  return self.grid.width
end

function Map:get_height()
  return self.grid.height
end

return Map
