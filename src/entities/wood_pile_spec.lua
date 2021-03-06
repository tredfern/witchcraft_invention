-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Entity - wood_pile", function()
  local wood_pile = require "entities.wood_pile"

  it("contains a count of the wood resources in the pile", function()
    local wp = wood_pile:new(4, 5)
    assert.is_true(wp.storable)
    assert.equals(100, wp.wood)
  end)
end)
