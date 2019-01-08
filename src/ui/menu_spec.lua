-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Menu", function()
  local Menu = require "ui.menu"

  it("warns when no font or color is selected", function()
    assert.has.errors(function() Menu:new() end)
    assert.has.errors(function() Menu:new(love.graphics.newFont()) end)
  end)

  it("has a list of items for the menu, with first item has focused", function()
    local m = Menu:new(love.graphics.newFont(), {})
    m:add_item("Option A", function() end)
    m:add_item("Option B", function() end)
    assert.equals(2, #m.items)
    assert.equals(m.items[1], m:get_focused_item())
  end)

  it("can trigger the callback function for a menu item that has focus", function()
    local m = Menu:new(love.graphics.newFont(), {})
    local callback = spy.new(function() end)
    m:add_item("Option", callback)
    m:click()
    assert.spy(callback).was.called()
  end)

  it("draws each item text with spacing based on items", function()
    local m = Menu:new(love.graphics.newFont(), {})
    m.x, m.y,m.spacing = 20, 40, 10
    m:add_item("Option 1", function() end)
    m:add_item("Option 2", function() end)
    m:add_item("Option 3", function() end)

    m.items[1].label.draw = spy.new(function() end)
    m.items[2].label.draw = spy.new(function() end)
    m.items[3].label.draw = spy.new(function() end)
    m:draw()
    assert.spy(m.items[1].label.draw).was.called()
    assert.spy(m.items[2].label.draw).was.called()
    assert.spy(m.items[3].label.draw).was.called()
    assert.equals(20, m.items[1].label.x)
    assert.equals(40, m.items[1].label.y)
    assert.equals(20, m.items[2].label.x)
    assert.equals(50, m.items[2].label.y)
    assert.equals(20, m.items[3].label.x)
    assert.equals(60, m.items[3].label.y)
  end)

  it("draws a focus indicator next to the selected item", function()
    local m = Menu:new(love.graphics.newFont(), {})
    m.x, m.y,m.spacing = 20, 40, 10
    m:add_item("Option 1", function() end)
  end)

  describe("changing the focus to the next item", function()
    local m = Menu:new(love.graphics.newFont(), {})
    m.x, m.y, m.spacing = 20, 40, 10
    m:add_item("Option 1", function() end)
    m:add_item("Option 2", function() end)
    m:add_item("Option 3", function() end)

    it("can change the focused item to the next item in the list", function()
      m:next_item()
      assert.equals(m.items[2], m:get_focused_item())
    end)

    it("can change the focused item to the previous item in the list", function()
      m:previous_item()
      assert.equals(m.items[1], m:get_focused_item())
    end)

    it("doesn't move past the first item", function()
      m:previous_item()
      m:previous_item()
      m:previous_item()
      m:previous_item()
      assert.equals(m.items[1], m:get_focused_item())
    end)

    it("doesn't continue past the last item", function()
      m:next_item()
      m:next_item()
      m:next_item()
      m:next_item()
      m:next_item()
      m:next_item()
      assert.equals(m.items[3], m:get_focused_item())
    end)

    it("draws a focus indicator next to the selected item", function()
      m:next_item()
      m.focus_indicator.draw = spy.new(function() end)
      m:draw()
      assert.equals(5, m.focus_indicator.x)
      assert.equals(m:get_focused_item().label.y, m.focus_indicator.y)
      assert.spy(m.focus_indicator.draw).was.called()
    end)

  end)
end)
