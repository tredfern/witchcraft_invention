-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Game = {}

local randomly = require("randomly")
local TextTiles = require("text_tiles")
local mf = TextTiles.default
local cursor = require "cursor"
local Map = require("map")
local Terrain = require("terrain")
local m = Map:new(100, 100)
for x=1,100 do
  for y=1,100 do
    local t = randomly.choose({"grass", "dirt", "water"})
    m:set_terrain(x, y, Terrain:get_terrain(t))
  end
end
cursor.x, cursor.y = m:get_width() / 2, m:get_height() / 2

function Game:draw()
  love.graphics.setFont(mf.font)
  local sw, sh = mf:get_screen_tile_size()
  local left, top = math.floor(cursor.x - sw / 2), math.floor(cursor.y - sh / 2)
  for x=1,m:get_width() do
    for y=1,m:get_height() do
      local t = m:get(x, y)
      if t then
        mf:draw(t.symbol, x - left, y - top, t.color)
      end
    end
  end
  cursor:draw()
end

function Game:keypressed(key)
  if key == "up" then
    cursor.y = cursor.y - 1
  end

  if key == "down" then
    cursor.y = cursor.y + 1
  end

  if key == "left" then
    cursor.x = cursor.x - 1
  end

  if key == "right" then
    cursor.x = cursor.x + 1
  end
end

return Game
