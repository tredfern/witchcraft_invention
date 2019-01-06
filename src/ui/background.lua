-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Background = {}

function Background:new(image_name)
  local b = {
    image = love.graphics.newImage(image_name)
  }
  setmetatable(b, self)
  self.__index = self
  return b
end

function Background:draw()
  local x = love.graphics.getWidth() / 2 - self.image:getWidth() / 2
  local y = love.graphics.getHeight() / 2 - self.image:getHeight() / 2
  love.graphics.draw(self.image, x, y)
end

return Background
