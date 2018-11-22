-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local size = {}

function size:new(w, h)
  local s = {
    width = w,
    height = h
  }
  return s
end

function size:add(entity, width, height)
  entity.size = size:new(width, height)
end

return size
