-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Sprites = require "graphics.sprites"
local SpriteSheet = require "graphics.spritesheet"
local Sprite = require "components.sprite"
local terrainSheet = SpriteSheet:new{
  name = "basesheet.png",
  width = 16, height = 16, margin = 1
}
local Terrain = {}
local loaded_terrains = {}

function Terrain:new(name, sprite)
  if loaded_terrains[name] ~= nil then
    return loaded_terrains[name]
  end

  local t = {
    name = name,
    sprite = sprite
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
  return self:new("grass", Sprites.terrains.grass())
end

function Terrain:dirt()
  return self:new("dirt", Sprites.terrains.dirt())
end

function Terrain:water()
  return self:new("water", Sprites.terrains.water())
end

function Terrain:none()
  return self:new("none", nil)
end

Terrain:grass()
Terrain:dirt()
Terrain:water()
Terrain:none()

return Terrain
