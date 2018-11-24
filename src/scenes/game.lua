-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Game = {}
local tiny = require "ext.tiny-ecs"
local systems = require "systems"
local world = tiny.world()
local settings = require "settings"

world:addSystem(systems.render_map)
world:addSystem(systems.render_symbols)
world:addSystem(systems.assign_tasks)

local draw_filter = tiny.requireAll("is_draw_system")
local update_filter = tiny.rejectAny("is_draw_system")

-- Used for drawing map...
local mf = settings.symbol_font

--- creates a map
local MapGenerator = require "map_generator"
local map = MapGenerator.create(250, 250, world)

-- cursor or camera?
local cursor = require "cursor"
cursor.x, cursor.y = map:get_width() / 2, map:get_height() / 2

local character = require "entities.character"
world:addEntity(character:new(cursor.x, cursor.y))

local stockpile = require "entities.stockpile"
world:addEntity(stockpile:new(cursor.x + 10, cursor.y + 10, 6, 6))

Game.world = world

function Game:draw()
  --Camera logic....
  local sw, sh = mf:get_screen_tile_size()
  local left, top = math.floor(cursor.x - sw / 2), math.floor(cursor.y - sh / 2)
  love.graphics.origin()
  love.graphics.translate(-left * mf.width, -top * mf.height)

  local dt = love.timer.getDelta()
  world:update(dt, draw_filter)
  cursor:draw()
end

function Game:update(dt)
  world:update(dt, update_filter)
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
