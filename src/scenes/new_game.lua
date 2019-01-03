-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "ext.class"
local Scene = require "scenes.scene"
local NewGame = class("NewGame", Scene)

function NewGame:draw()
  love.graphics.print("New Game")
  love.graphics.print("[Space] to start game", 10, 10)
  love.graphics.print("[Escape] to title screen", 10, 20)
end

function NewGame:keypressed(key)
  if key == "space" then
    self:start_game()
  end

  if key == "escape" then
    self:title()
  end
end

function NewGame:start_game()
  require "scenes.game":new():activate()
end

function NewGame:title()
  require "scenes.title":new():activate()
end



return NewGame
