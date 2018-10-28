-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local searchpath = love.filesystem.getRequirePath()
searchpath = searchpath .. ";src/?.lua;src/?/init.lua;"
love.filesystem.setRequirePath(searchpath)

local statemachine = require("statemachine")
local scenes = statemachine:new({"update", "draw", "keypressed"})
scenes.title = require("scenes.title")
scenes.game = require("scenes.game")
scenes:change(scenes.game)

function love.load()
end

function love.draw()
  scenes:draw()
end

function love.update()
  scenes:update()
end

function love.keypressed(key, scancode)
  scenes:keypressed(key, scancode)

  if key == "escape" then
    love.event.quit()
  end
end

