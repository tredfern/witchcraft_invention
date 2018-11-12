-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local MapSquare = {}

function MapSquare:new(x, y)
  local sqr = {
    x = x,
    y = y,
    objects = {}
  }
  self.__index = self
  setmetatable(sqr, self)
  return sqr
end

function MapSquare:set_terrain(terrain)
  self.terrain = terrain
end

function MapSquare:get_terrain()
  return self.terrain
end

function MapSquare:add(obj)
  self.objects[#self.objects + 1] = obj
end

function MapSquare:get_objects()
  return self.objects
end


return MapSquare
