-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Button", function()
  local Button = require "ui.button"

  describe("basic button behavior", function()
    local callback = spy.new(function() end)
    local b = Button:new("Hello", callback)

    it("has a label with the appropriate text on it", function()
      assert.equals("Hello", b.label.text)
    end)

    it("calls back when told a click has occurred", function()
      b:click()
      assert.spy(callback).was.called()
    end)
  end)
end)
