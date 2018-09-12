-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local searchpath = love.filesystem.getRequirePath()
searchpath = searchpath .. ";src/?.lua;src/?/init.lua;"
love.filesystem.setRequirePath(searchpath)

local statemachine = require("statemachine")
local scenes = statemachine:new({"update", "draw"})
scenes.title = require("scenes.title")

function love.load()
  scenes:change(scenes.title)
end

function love.draw()
  scenes:draw()
end

function love.update(dt)
  scenes:update(dt)
end
