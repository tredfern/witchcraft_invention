-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("character", function()
  local character = require "entities.character"

  it("has a filter that can find just characters", function()
    local c = character:new(10, 10)
    assert.is_true(character.filter(nil, c))
    assert.is_false(character.filter(nil, {}))
  end)
end)
