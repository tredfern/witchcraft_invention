-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Systems - EntityTracker", function()
  local systems = require "systems"
  local tiny = require "ext.tiny-ecs"

  it("organizes the entities based on entity_type field value", function()
    local e = { entity_type = 1 }
    local e2 = { entity_type = 2 }

    tiny.world(systems.entity_tracker, e, e2)

    assert.array_includes(e, systems.entity_tracker:find_entity_type(1))
    assert.array_includes(e2, systems.entity_tracker:find_entity_type(2))
  end)
end)
