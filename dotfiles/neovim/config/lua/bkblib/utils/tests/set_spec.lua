local Set = require("bkblib.utils.set")

describe("Set", function()
  describe(".mk()", function()
    describe("should create an empty set with internal set metatable when passing", function()
      local function assert_empty_set(set)
        assert.are.same(set, Set._mk_empty_set())
        assert.are.equal(getmetatable(set), Set._set_mt.__metatable)
      end
      it("no arguments", function()
        assert_empty_set(Set.mk())
      end)
      it("empty table", function()
        assert_empty_set(Set.mk({}))
      end)
      it("false", function()
        assert_empty_set(Set.mk(false))
      end)
      it("nil", function()
        assert_empty_set(Set.mk(nil))
      end)
    end)
    it("should create a set that contians all specified elements and only these elements given an indexed table of elements", function()
      local original_table = { "hello", "world", "hello", "test", 1 }
      local set = Set.mk(original_table)

      for _, e in pairs(original_table) do
        assert.is_true(set(e))
      end

      assert.is_false(set("non existent"))
      assert.is_false(set(2))
    end)
    describe("fails when passing", function()
      it("a number", function()
        assert.has_error(function() Set.mk(10) end)
      end)
      it("a string", function()
        assert.has_error(function() Set.mk("test") end)
      end)
      it("true", function()
        assert.has_error(function() Set.mk(true) end)
      end)
    end)
    it("should create a copy of a set if set is passed", function()
      local set = Set.mk({ "test" })
      local set_copy = Set.mk(set)

      assert.are.same(set, set_copy)
      assert.are_not.equal(set, set_copy)
    end)
  end)
  describe(".is_set()", function()
    describe("should return true if the argument is", function()
      it("an empty set", function()
        assert.is_true(Set.is_set(Set.mk()))
      end)
      it("a non empty set", function()
        assert.is_true(Set.is_set(Set.mk({ "test" })))
      end)
    end)
    describe("should return false if the argument is", function()
      it("a table", function()
        assert.is_false(Set.is_set({ _data = { test = true } }))
      end)
      it("a number", function()
        assert.is_false(Set.is_set(1))
      end)
      it("a string", function()
        assert.is_false(Set.is_set("test"))
      end)
      it("false", function()
        assert.is_false(Set.is_set(false))
      end)
      it("true", function()
        assert.is_false(Set.is_set(true))
      end)
      it("nil", function()
        assert.is_false(Set.is_set(nil))
      end)
    end)
    it("should return true if the argument is a Set", function()
    end)
  end)
  describe("instance", function()
    -- TODO: test that the operatoins are immutable
    describe("+", function()
      -- TODO
      describe("creates a new set contating elements from the original set and", function()
        it("another set", function()
          local left = Set.mk({ "hello", "world" })
          local right = Set.mk({ "world", "test" })

          local actual = left + right
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(actual, expected)

          assert.are.same(left, Set.mk({ "hello", "world" }))
          assert.are.same(right, Set.mk({ "world", "test" }))
        end)
        it("a table of indexed elements", function()
          local left = Set.mk({ "hello", "world" })
          local right = { "world", "test" }

          local actual = left + right
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(actual, expected)

          assert.are.same(left, Set.mk({ "hello", "world" }))
          assert.are.same(right, { "world", "test" })
        end)
        it("a number", function()
          local set = Set.mk({ "hello", "world" })

          local actual = set + 10
          local expected = Set.mk({ "hello", "world", 10 })

          assert.are.same(actual, expected)

          assert.are.same(set, Set.mk({ "hello", "world" }))
        end)
        it("a string", function()
          local set = Set.mk({ "hello", "world" })

          local actual = set + "test"
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(actual, expected)

          assert.are.same(set, Set.mk({ "hello", "world" }))
        end)
        it("a boolean", function()
          local set = Set.mk({ "hello", "world", true })

          local actual = (set + true) + false
          local expected = Set.mk({ "hello", "world", true, false })

          assert.are.same(actual, expected)

          assert.are.same(set, Set.mk({ "hello", "world", true }))
        end)
      end)
    end)
    describe("-", function()
      -- TODO
      assert.is_true(false)
    end)
    describe("*", function()
      -- TODO
      assert.is_true(false)
    end)
    describe("..", function()
      -- TODO
      assert.is_true(false)
    end)
    describe("len()", function()
      -- TODO
      assert.is_true(false)
    end)
    describe("<", function()
      -- TODO
      assert.is_true(false)
    end)
    describe("<=", function()
      -- TODO
      assert.is_true(false)
    end)
    describe("==", function()
      -- TODO
      assert.is_true(false)
    end)
    describe(".contains", function()
      -- TODO
      assert.is_true(false)
    end)
    describe("()", function()
      it("returns true when an element is in the set and does not mutate the set", function()
        local key_to_search = "test"
        local set = Set.mk({ key_to_search, "hello" })
        local set_copy = Set.mk(set)

        assert.is_true(set(key_to_search))

        assert.are.same(set, set_copy)
      end)
      it("returns false when an element is not in the set", function()
        local set = Set.mk({ "test", "hello" })
        local set_copy = Set.mk(set)

        assert.is_false(set("world"))

        assert.are.same(set, set_copy)
      end)
    end)
  end)
end)
