-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local settings = {}
local text_tiles = require "text_tiles"
settings.symbol_font = text_tiles:new("FreeMono.ttf", 16)
settings.ui_font = text_tiles:new("FreeMono.ttf", 12)
settings.tile_width = 16
settings.tile_height = 16

return settings
