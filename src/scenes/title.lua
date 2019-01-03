-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Scene = require "scenes.scene"
local Title = Scene:subclass("Title")


function Title:draw()
  love.graphics.print("Title Screen")
  love.graphics.print("[N]ew Game", 10, 10)
  love.graphics.print("[L]oad Game", 10, 20)
  love.graphics.print("[S]ettings", 10, 30)
  love.graphics.print("[Q]uit Game", 10, 50)
end

function Title:keypressed(key)
  if Title[key] then
    Title[key](self)
  end
end

function Title:new_game()
  require "scenes.new_game":new():activate()
end

function Title:load_game()
  require "scenes.load_game":new():activate()
end

function Title:settings()
  require "scenes.settings":new():activate()
end

function Title:quit()
  love.event.quit()
end

Title["n"] = Title.new_game
Title["l"] = Title.load_game
Title["s"] = Title.settings
Title["q"] = Title.quit

return Title
