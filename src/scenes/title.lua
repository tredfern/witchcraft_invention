-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "ext.class"
local Scene = require "scenes.scene"
local NewGame = require "scenes.new_game"
local Title = class("Title", Scene)

function Title:draw()
  love.graphics.print("Title Screen")
end

function Title:new_game()
  NewGame:new():activate()
end

return Title
