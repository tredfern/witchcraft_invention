-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local SpriteSheet = require "graphics.spritesheet"
local Sprite = require "graphics.sprite"
local terrainSheet = SpriteSheet:new{
  name = "basesheet.png",
  width = 16, height = 16, margin = 1
}
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
  local g = self:new("grass", "☷", {0,0.7,0,0.7})
  g.sprite = Sprite:new{
    sheet = terrainSheet,
    tx = 5, ty = 0
  }
  return g
end

function Terrain:dirt()
  local d = self:new("dirt", "⁖", {0.6, 0.6, 0.1, 0.7})
  d.sprite = Sprite:new{
    sheet = terrainSheet,
    tx = 6, ty = 0
  }
  return d
end

function Terrain:water()
  local w = self:new("water", "≈", {0.2, 0.5, 0.8, 0.8})
  w.sprite = Sprite:new{
    sheet = terrainSheet,
    tx = 0, ty = 0
  }
  return w
end

function Terrain:none()
  return self:new("none", " ", {0, 0, 0, 0})
end

Terrain:grass()
Terrain:dirt()
Terrain:water()
Terrain:none()

return Terrain
