-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Sprite = {}
local Logger = require "logger"

function Sprite:new(sprite)
  local s = sprite or {}
  setmetatable(s, self)
  self.__index = self
  return s
end

function Sprite:draw(x, y)
  if self.image then
    love.graphics.draw(self.image, x, y)
  elseif self.sheet and self.tx and self.ty then
    local q = self.sheet:getQuad(self.tx, self.ty)
    love.graphics.draw(self.sheet.image, q, x, y)
  end
end

return Sprite
