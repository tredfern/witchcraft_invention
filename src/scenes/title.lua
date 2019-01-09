-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Fonts = require "graphics.fonts"
local Colors = require "colors"
local Scene = require "scenes.scene"
local Title = Scene:subclass("Title")
local background_image = require "ui.background":new("assets/images/title_background.png")
local Label = require "ui.label"
local Menu = require "ui.menu"

function Title:initialize()
  self.title_label = Label:new(Fonts.title, "Witchcraft and Invention", 50, 100, Colors.black)
  self.menu = Menu:new(Fonts.menu, Colors.black)
  self.menu.x, self.menu.y, self.menu.spacing = 75, 180, 25
  self.menu:add_item("New Game", self.new_game)
  self.menu:add_item("Load Game", self.load_game)
  self.menu:add_item("Settings", self.settings)
  self.menu:add_item("Quit Game", self.quit)

  self["up"] = function() self.menu:previous_item() end
  self["down"] = function() self.menu:next_item() end
  self["space"] = function() self.menu:click() end
  self["return"] = function() self.menu:click() end
end


function Title:draw()
  background_image:draw()
  self.title_label:draw()
  self.menu:draw()
end

function Title:keypressed(key)
  if self[key] then
    self[key](self)
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


return Title
