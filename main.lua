-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local utf8 = require("utf8")

local searchpath = love.filesystem.getRequirePath()
searchpath = searchpath .. ";src/?.lua;src/?/init.lua;"
love.filesystem.setRequirePath(searchpath)

local statemachine = require("statemachine")
local scenes = statemachine:new({"update", "draw"})
scenes.title = require("scenes.title")


local TextTiles = require("text_tiles")
local mf = TextTiles:new("FreeMono.ttf", 19)

local Map = require("map")
local Terrain = require("terrain")
local m = Map:new(100, 100)
for x=1,100 do
  for y=1,100 do
    m:set_terrain(x, y, Terrain:grass())
  end
end
local character = {
  x = 20, y = 20, symbol = utf8.char(0x2660), color = {0.3, 0.3, 0.9, 1}
}

function love.load()
end

function love.draw()
  love.graphics.setFont(mf.font)
  for x=1,m:get_width() do
    for y=1,m:get_height() do
      love.graphics.setColor(m:get(x, y).color)
      love.graphics.print(m:get(x, y).symbol, (x - 1) * mf.width, (y - 1) * mf.height)
    end
  end

  love.graphics.setColor(character.color)
  love.graphics.print(character.symbol, (character.x - 1) * mf.width, (character.y - 1) * mf.height)
end

function love.update()

end

function love.keypressed(key)
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
