-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Map = {}
local Grid = require "ext.artemis.src.grid"

function Map:new(width, height)
  local m = {
    grid = Grid:new(width, height)
  }
  self.__index = self
  setmetatable(m, self)
  return m
end

function Map:set_terrain(x, y, terrain)
  self.grid:set(x, y, terrain)
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
