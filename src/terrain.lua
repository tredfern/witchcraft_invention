-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Terrain = {}
local loaded_terrains = {}

function Terrain:new(name, image)
  if loaded_terrains[name] ~= nil then
    return loaded_terrains[name]
  end

  local t = {
    name = name,
    image = image
  }
  setmetatable(t, self)
  self.__index = self
  loaded_terrains[name] = t
  return t
end

function Terrain:grass()
  return self:new("grass", "images/grass.png")
end

return Terrain
