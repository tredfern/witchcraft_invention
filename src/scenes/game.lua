-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Game = {}
local tiny = require "ext.tiny-ecs"
local world = tiny.world()
world:addSystem(require "systems.render_map")
world:addSystem(require "systems.render_symbol_system")

-- Used for drawing map...
local TextTiles = require("text_tiles")
local mf = TextTiles.default

--- creates a map
local MapGenerator = require "map_generator"
local map = MapGenerator.create(250, 250, world)

-- cursor or camera?
local cursor = require "cursor"
cursor.x, cursor.y = map:get_width() / 2, map:get_height() / 2

local character = require "entities.character"
world:addEntity(character:new(cursor.x, cursor.y))

local stockpile = {
  position = {x = cursor.x + 5, y = cursor.y + 5},
  symbol = "#######\n#######\n#######\n#######",
  color = {1,0,0,1}
}
world:addEntity(stockpile)

function Game:draw()
  --Camera logic....
  local sw, sh = mf:get_screen_tile_size()
  local left, top = math.floor(cursor.x - sw / 2), math.floor(cursor.y - sh / 2)
  love.graphics.origin()
  love.graphics.translate(-left * mf.width, -top * mf.height)

  world:update()
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
