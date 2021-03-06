-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Logger = require "logger"
local paths = require "paths"
local SpriteSheet = {}

function SpriteSheet:new(settings)
  local s = settings
  Logger.debug:log("Loading sprite sheet: %s", s.name)
  s.image = love.graphics.newImage(paths.image_path .. s.name)
  s.tiles_wide = math.floor(s.image:getWidth() / (s.width + s.margin))
  setmetatable(s, self)
  self.__index = self
  return s
end

function SpriteSheet:getTileX(x)
  return self.width * x + self.margin * x
end

function SpriteSheet:getTileY(y)
  return self.height * y + self.margin * y
end

function SpriteSheet:getQuad(x, y)
  local tileID = y * self.tiles_wide + x

  local q = self[tileID] or self:createQuad(x, y)
  self[tileID] = q
  return q
end

function SpriteSheet:createQuad(x, y)
  Logger.debug:log("Creating quad(%d, %d)", x, y)
  Logger.debug:log("X = %d, Y = %d)", self:getTileX(x), self:getTileY(y) )

  return love.graphics.newQuad(
    self:getTileX(x),
    self:getTileY(y),
    self.width,
    self.height,
    self.image:getWidth(),
    self.image:getHeight()
  )
end

function SpriteSheet:setName(name, x, y)
  self[name] = self:getQuad(x, y)
end

return SpriteSheet
