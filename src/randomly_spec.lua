-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Randomly", function()
  local randomly = require "randomly"
  local mockrandom = require "ext/artemis/test_helpers/mock_random"

  it("can select random items out of a list", function()
    mockrandom.setreturnvalues({5, 5, 2, 3})
    local t = {1,2,3,4,5,6}
    assert.equals(5, randomly.choose(t))
    assert.equals(5, randomly.choose(t))
    assert.equals(2, randomly.choose(t))
    assert.equals(3, randomly.choose(t))
  end)
end)
