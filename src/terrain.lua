-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local utf8 = require "utf8"
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

function Terrain:get_terrain(name)
  return loaded_terrains[name]
end

function Terrain:grass()
  return self:new("grass", utf8.char(0x2637), {0,0.7,0,0.7})
end

function Terrain:dirt()
  return self:new("dirt", utf8.char(0x2056), {0.6, 0.6, 0.1, 0.7})
end

function Terrain:water()
  return self:new("water", utf8.char(0x2248), {0.2, 0.5, 0.8, 0.8})
end

Terrain:grass()
Terrain:dirt()
Terrain:water()

return Terrain
