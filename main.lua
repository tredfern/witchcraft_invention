-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local searchpath = love.filesystem.getRequirePath()
searchpath = searchpath .. ";src/?.lua;src/?/init.lua;"
love.filesystem.setRequirePath(searchpath)

local Scene = require "scenes.scene"
local Title = require "scenes.title"

function love.load()
  Title:new():activate()
end

function love.draw()
  Scene.current_scene:draw()
end

function love.update()
  Scene.current_scene:update()
end

function love.keypressed(key, scancode)
  Scene.current_scene:keypressed(key, scancode)
end

