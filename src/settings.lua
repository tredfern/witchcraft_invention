-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local settings = {}
local text_tiles = require "text_tiles"
settings.symbol_font = text_tiles:new("FreeMono.ttf", 24)
settings.ui_font = text_tiles:new("FreeMono.ttf", 16)

return settings
