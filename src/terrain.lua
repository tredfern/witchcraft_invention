-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Terrain = {}
local loaded_terrains = {}

function Terrain:new(name, symbol, color)
  if loaded_terrains[name] ~= nil then
    return loaded_terrains[name]
  end

  local t = {
    name = name,
    symbol = symbol,
    color = color
  }
  setmetatable(t, self)
  self.__index = self
  loaded_terrains[name] = t
  return t
end

function Terrain:grass()
  return self:new("grass", ".", {0,0.7,0,0.7})
end

return Terrain
