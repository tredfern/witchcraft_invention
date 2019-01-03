-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Scene = require "scenes.scene"
local Game = Scene:subclass("Game")
local tiny = require "ext.tiny-ecs"
local systems = require "systems"
local settings = require "settings"

local world = tiny.world(
  systems.render_map,
  systems.render_sprites,
  systems.render_symbols,
  systems.gui_display,
  systems.entity_factory,
  systems.entity_tracker,
  systems.gather_resources,
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
  love.graphics.translate(-left * settings.tile_width, -top * settings.tile_height)

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

  if key == "escape" then
    love.event.quit()
  end
end

function Game:setup_ui()
  local DisplayLog = require "ui.display_log"
  self.display_log = DisplayLog:new()
  self.display_log:anchor_right()
  self.display_log:anchor_bottom()
  world:addEntity(self.display_log)
end

Game:setup_ui()


return Game
