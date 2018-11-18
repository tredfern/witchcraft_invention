-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("tree", function()
  local tree = require "entities.tree"
  it("cannot be placed in water", function()
    local t = tree:new(10, 10)
    local terrain = require "terrain"
    assert.array_includes(terrain:water(), t.disallowed_terrains)
  end)

  it("provides a filter for finding tree entities", function()
    local t = tree:new(10, 10)
    assert.is_true(tree.filter(nil, t))
  end)
end)
