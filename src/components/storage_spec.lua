-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Components - Storage", function()
  local Storage = require "components.storage"

  it("can add an item to the storage", function()
    local s = Storage:new()
    local item = {}

    assert.is_false(s:contains(item))
    s:add(item)
    assert.is_true(s:contains(item))
  end)

  it("can remove an item from storage", function()
    local s = Storage:new()
    local item = {}
    s:add(item)
    assert.is_true(s:contains(item))
    s:remove(item)
    assert.is_false(s:contains(item))
  end)
end)
