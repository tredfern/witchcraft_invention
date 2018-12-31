-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local SpriteSheet = require "graphics.spritesheet"
local Sprite = require "components.sprite"
local base = SpriteSheet:new {
  name = "basesheet.png",
  width = 16,
  height = 16,
  margin = 1
}
local characters = SpriteSheet:new {
  name = "characterSheet.png",
  width = 16,
  height = 16,
  margin = 1
}
local ui = SpriteSheet:new {
  name = "ui.png",
  width = 16,
  height = 16,
  margin = 2
}

local function SpriteConstructor(sheet, x, y)
  return function()
    return Sprite:new{
      sheet = sheet,
      tx = x,
      ty = y
    }
  end
end

local Sprites = { }
Sprites.character = SpriteConstructor(characters, 0, 0)
Sprites.tree = SpriteConstructor(base, 13, 9)
Sprites.stockpile = SpriteConstructor(base, 5, 2)
Sprites.wood_pile = SpriteConstructor(base, 41, 10)

Sprites.terrains = {
  grass = SpriteConstructor(base, 5, 0),
  dirt = SpriteConstructor(base, 6, 0),
  water = SpriteConstructor(base, 0, 0)
}
Sprites.ui = {
  cursor = SpriteConstructor(ui, 26, 19)
}

return Sprites
