-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Game = {}

local utf8 = require("utf8")
local randomly = require("randomly")
local TextTiles = require("text_tiles")
local mf = TextTiles:new("FreeMono.ttf", 19)
local Map = require("map")
local Terrain = require("terrain")
local m = Map:new(100, 100)
for x=1,100 do
  for y=1,100 do
    local t = randomly.choose({"grass", "dirt", "water"})
    m:set_terrain(x, y, Terrain:get_terrain(t))
  end
end
local character = mf:new_tile(utf8.char(0x2660), 20, 20, { 0.3, 0.3, 0.9, 1})

function Game:draw()
  love.graphics.setFont(mf.font)
  for x=1,m:get_width() do
    for y=1,m:get_height() do
      local t = m:get(x, y)
      mf:draw(t.symbol, x, y, t.color)
    end
  end
  character:draw()
end

function Game:keypressed(key)
  if key == "up" then
    character.y = character.y - 1
  end

  if key == "down" then
    character.y = character.y + 1
  end

  if key == "left" then
    character.x = character.x - 1
  end

  if key == "right" then
    character.x = character.x + 1
  end
end

return Game
