-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Game = {}

-- Used for drawing map...
local TextTiles = require("text_tiles")
local mf = TextTiles.default
--
local cursor = require "cursor"

--- creates a map
local MapGenerator = require "map_generator"
local map = MapGenerator.create(250, 250)

cursor.x, cursor.y = map:get_width() / 2, map:get_height() / 2
local tree = require "entities.tree"
local character = require "entities.character"
local entities = { }
for _=1,1000 do
  local x, y = math.random(250), math.random(250)
  entities[#entities + 1] = tree:new(x, y)
end

for _ = 1, 10 do
  local x, y = cursor.x + math.random(-5, 5), cursor.y + math.random(-5, 5)
  entities[#entities + 1] = character:new(x, y)
end


function Game:draw()
  --Camera logic....
  local sw, sh = mf:get_screen_tile_size()
  local left, top = math.floor(cursor.x - sw / 2), math.floor(cursor.y - sh / 2)
  love.graphics.origin()
  love.graphics.translate(-left * mf.width, -top * mf.height)

  self:draw_map()
  for _, v in ipairs(entities) do
    mf:draw(v.symbol, v.x, v.y, v.color)
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

function Game:draw_map()
  for x=1,map:get_width() do
    for y=1,map:get_height() do
      local t = map:get(x, y)
      if t then
        mf:draw(t.symbol, x, y, t.color)
      end
    end
  end
end

return Game
