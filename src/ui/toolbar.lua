-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Window = require "ui.window"
local Toolbar = Window:new()
local List = require "ext.artemis.src.list"

function Toolbar:add(btn)
  self.buttons = self.buttons or List:new()
  self.buttons:add(btn)
end

return Toolbar
