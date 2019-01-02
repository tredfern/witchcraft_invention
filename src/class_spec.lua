-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("class", function()
  local class = require "class"

  describe("type names", function()
    it("requires a type name for a class", function()
      local imp = class("type name")
      assert.equals("type name", imp.type_name)
    end)

    it("provides a method to check if object is of a type", function()
      local imp = class("type name")
      local instance = imp:new()
      assert.is_true(instance:is(imp))
    end)
  end)

  describe("simple class implementation", function()
    it("can instantiate a new instance of class", function()
      local imp = class("object")
      local instance1 = imp:new()
      local instance2 = imp:new()
      assert.not_equal(instance1, instance2)
      assert.equals(type({}), type(instance1))
    end)

    it("classes can have methods added to them that all instances get", function()
      local imp = class("object")
      imp.method1 = function(self) return 3 end
      imp.method2 = function(self) return 4 end
      local instance = imp:new()
      assert.equals(3, instance:method1())
      assert.equals(4, instance:method2())
    end)
  end)
end)
