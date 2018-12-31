-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("character", function()
  local character = require "entities.character"

  it("is drawable", function()
    local c = character:new(10, 10)
    assert.is_not.equal(nil, c.position)
    assert.is_not.equal(nil, c.sprite)
  end)

  it("has a filter that can find just characters", function()
    local c = character:new(10, 10)
    assert.is_true(character.filter(nil, c))
    assert.is_false(character.filter(nil, {}))
  end)

  it("is flagged as a worker for performing actions", function()
    local c = character:new(10, 10)
    assert.is_true(c.is_worker)
  end)

  it("characters have a speed", function()
    local c = character:new(10, 10)
    assert.is_not.equal(nil, c.speed)
  end)

  it("can carray things", function()
    local c= character:new(10, 10)
    assert.not_equal(nil, c.inventory)
  end)
end)
