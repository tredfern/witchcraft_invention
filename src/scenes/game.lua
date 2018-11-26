-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Game = {}
local tiny = require "ext.tiny-ecs"
local systems = require "systems"
local settings = require "settings"

local world = tiny.world(
  systems.render_map,
  systems.render_symbols,
  systems.entity_factory,
  systems.process_user_commands,
  systems.assign_tasks,
  systems.perform_actions
)

local draw_filter = tiny.requireAll("is_draw_system")
local update_filter = tiny.rejectAny("is_draw_system")

-- Used for drawing map...
local mf = settings.symbol_font

--- creates a map
local MapGenerator = require "map_generator"
local map = MapGenerator.create(250, 250, world)

-- cursor or camera?
local cursor = require "entities.cursor":new(
  map:get_width() / 2,
  map:get_height() / 2
)
world:addEntity(cursor)

local character = require "entities.character"
world:addEntity(character:new(cursor.position.x, cursor.position.y))

local stockpile = require "entities.stockpile"
world:addEntity(stockpile:new(cursor.position.x + 10, cursor.position.y + 10, 6, 6))

Game.world = world

function Game:draw()
  --Camera logic....
  local sw, sh = mf:get_screen_tile_size()
  local left, top = math.floor(cursor.position.x - sw / 2), math.floor(cursor.position.y - sh / 2)
  love.graphics.origin()
  love.graphics.translate(-left * mf.width, -top * mf.height)

  local dt = love.timer.getDelta()
  world:update(dt, draw_filter)
end

function Game:update()
  local dt = love.timer.getDelta()
  world:update(dt, update_filter)
end

function Game:keypressed(key)
  if key == "up" then
    cursor.position.y = cursor.position.y - 1
  end

  if key == "down" then
    cursor.position.y = cursor.position.y + 1
  end

  if key == "left" then
    cursor.position.x = cursor.position.x - 1
  end

  if key == "right" then
    cursor.position.x = cursor.position.x + 1
  end
end

return Game
