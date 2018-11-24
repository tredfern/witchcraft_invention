-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT


local bag = require "ext.artemis.src.bag"
local find_entity_helper = {}

function find_entity_helper:by_position(entities, x, y)
  local results = bag:new()

  -- This is an incredibly inefficient implementation... and it will do for now...
  for _, v in ipairs(entities) do
    if v.position and v.position.x == x and v.position.y == y then
      results:add(v)
    end
  end
  return results
end

function find_entity_helper:by_name(entities, name)
  local results = bag:new()

  -- This is an incredibly inefficient implementation... and it will do for now...
  for _, v in ipairs(entities) do
    if v.name == name then
      results:add(v)
    end
  end
  return results
end

return find_entity_helper
