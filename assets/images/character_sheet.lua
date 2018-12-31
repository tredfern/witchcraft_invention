-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local SpriteSheet = require "graphics.spritesheet"
local Sprite = require "graphics.sprite"
local CharacterSheet = SpriteSheet:new{ name = "characterSheet.png", width = 16, height = 16, margin = 1}
CharacterSheet.sprites = {
  character = function()
    return Sprite:new{
      sheet = CharacterSheet,
      tx = 0,
      ty = 0
    }
  end
}

return CharacterSheet
