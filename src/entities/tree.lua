-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local List = require "ext.artemis.src.list"
local terrain = require "terrain"
local position = require "components.position"
local Sprites = require "graphics.sprites"

local tree = {
  is_tree = true,
  disallowed_terrains = List:new({ terrain:water() }),
  filter = tiny.requireAll("is_tree", "position")
}

function tree:new(x, y)
  local t = {
    position = position:new(x, y),
    sprite = Sprites.tree()
  }
  setmetatable(t, self)
  self.__index = self
  return t
end

return tree
