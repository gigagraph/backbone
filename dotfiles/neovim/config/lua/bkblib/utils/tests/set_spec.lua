local Set = require("bkblib.utils.set")

describe("Set", function()
  describe(".mk()", function()
    describe("should create an empty set with internal set metatable when passing", function()
      local function assert_empty_set(set)
        assert.are.same(Set._mk_empty_set(), set)
        assert.are.equal(Set._set_mt.__metatable, getmetatable(set))
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
    describe("+", function()
      describe("creates a new set contating elements from the original set and", function()
        it("another set", function()
          local left = Set.mk({ "hello", "world" })
          local right = Set.mk({ "world", "test" })

          local actual = left + right
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual)

          assert.are.same(Set.mk({ "hello", "world" }), left)
          assert.are.same(Set.mk({ "world", "test" }), right)
        end)
        it("a table of indexed elements", function()
          local left = Set.mk({ "hello", "world" })
          local right = { "world", "test" }

          local actual = left + right
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual)

          assert.are.same(Set.mk({ "hello", "world" }), left)
          assert.are.same({ "world", "test" }, right)
        end)
        it("a number", function()
          local set = Set.mk({ "hello", "world" })

          local actual = set + 10
          local expected = Set.mk({ "hello", "world", 10 })

          assert.are.same(expected, actual)

          assert.are.same(Set.mk({ "hello", "world" }), set)
        end)
        it("a string", function()
          local set = Set.mk({ "hello", "world" })

          local actual = set + "test"
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual)

          assert.are.same(Set.mk({ "hello", "world" }), set)
        end)
        it("a boolean", function()
          local set = Set.mk({ "hello", "world", true })

          local actual = (set + true) + false
          local expected = Set.mk({ "hello", "world", true, false })

          assert.are.same(expected, actual)

          assert.are.same(Set.mk({ "hello", "world", true }), set)
        end)
        it("nil", function()
          local set = Set.mk({ "hello", "world", true })

          local actual = set + nil
          local expected = Set.mk({ "hello", "world", true })

          assert.are.same(expected, actual)

          assert.are.same(Set.mk({ "hello", "world", true }), set)
        end)
      end)
    end)
    describe("-", function()
      it("creates a new set that is the same as the original wihtout the subtracted element", function()
        local set = Set.mk({ "test", "string1", 1, 2 })

        local subtraction_result = (set - "test") - 2

        assert.are.same(Set.mk({"string1", 1}), subtraction_result)

        assert.are.same(Set.mk({ "test", "string1", 1, 2 }), set)
      end)
      it("creates a new set that is the same as the original wihtout the subtracted elements of the table", function()
        local set = Set.mk({ "test", "string1", 1, 2 })

        local subtraction_result = set - { "test", 2 }

        assert.are.same(Set.mk({"string1", 1}), subtraction_result)

        assert.are.same(Set.mk({ "test", "string1", 1, 2 }), set)
      end)
      it("creates a new set that is the same as the original wihtout the subtracted elements of another set", function()
        local set = Set.mk({ "test", "string1", 1, 2 })

        local subtraction_result = set - Set.mk({ "test", 2 })

        assert.are.same(Set.mk({"string1", 1}), subtraction_result)

        assert.are.same(Set.mk({ "test", "string1", 1, 2 }), set)
      end)
      it("creates a new set that is the same as the original when subtracting nil", function()
        local set = Set.mk({ "test", "string1", 1, 2 })

        local subtraction_result = set - nil

        assert.are.same(Set.mk({ "test", "string1", 1, 2 }), subtraction_result)

        assert.are.same(Set.mk({ "test", "string1", 1, 2 }), set)
      end)
    end)
    describe("*", function()
      describe("should produce a new set containing elements that appear in both arguments at the same time when intersecting with", function()
        describe("another Set", function()
          it("that has some intersecting elements", function()
            local left = Set.mk({ "test", "string1", 1, 2 })
            local right = Set.mk({ "string1", 2 })

            local intersection_result = left * right

            assert.are.same(Set.mk({ "string1", 2 }), intersection_result)

            assert.are.same(Set.mk({ "test", "string1", 1, 2 }), left)
            assert.are.same(Set.mk({ "string1", 2 }), right)
          end)
          it("that does not have any intersecting elements", function()
            local left = Set.mk({ "test", "string1", 1, 2 })
            local right = Set.mk({ "string2", 3 })

            local intersection_result = left * right

            assert.are.same(Set.mk(), intersection_result)

            assert.are.same(Set.mk({ "test", "string1", 1, 2 }), left)
            assert.are.same(Set.mk({ "string2", 3 }), right)
          end)
        end)
        describe("a table Int -> number", function()
          it("that has some intersecting elements", function()
            local left = Set.mk({ "test", "string1", 1, 2 })
            local right = { "string1", 2 }

            local intersection_result = left * right

            assert.are.same(Set.mk({ "string1", 2 }), intersection_result)

            assert.are.same(Set.mk({ "test", "string1", 1, 2 }), left)
            assert.are.same({ "string1", 2 }, right)
          end)
          it("that does not have any intersecting elements", function()
            local left = Set.mk({ "test", "string1", 1, 2 })
            local right = { "string2", 3 }

            local intersection_result = left * right

            assert.are.same(Set.mk(), intersection_result)

            assert.are.same(Set.mk({ "test", "string1", 1, 2 }), left)
            assert.are.same({ "string2", 3 }, right)
          end)
        end)
      end)
      describe("should return the empty set when intersecting it with nil", function()
        local left = Set.mk({ "test", "string1", 1, 2 })

        local intersection_result = left * nil

        assert.are.same(Set.mk(), intersection_result)

        assert.are.same(Set.mk({ "test", "string1", 1, 2 }), left)
      end)
      describe("fails when trying to intersecct with", function()
        it("a number", function()
          assert.has_error(function()
            local set = Set.mk({ "test", "string1", 1, 2 })
            local _ = set * 2
          end)
        end)
        it("a string", function()
          assert.has_error(function()
            local set = Set.mk({ "test", "string1", 1, 2 })
            local _ = set * "test"
          end)
        end)
        it("a boolean", function()
          assert.has_error(function()
            local set = Set.mk({ "test", "string1", 1, 2, true })
            local _ = set * true
          end)
        end)
      end)
    end)
    describe("..", function()
      describe("creates a new set contating elements from the original set and", function()
        it("another set", function()
          local left = Set.mk({ "hello", "world" })
          local right = Set.mk({ "world", "test" })

          local actual = left .. right
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual)

          assert.are.same(Set.mk({ "hello", "world" }), left)
          assert.are.same(Set.mk({ "world", "test" }), right)
        end)
        it("a table of indexed elements", function()
          local left = Set.mk({ "hello", "world" })
          local right = { "world", "test" }

          local actual = left .. right
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual)

          assert.are.same(Set.mk({ "hello", "world" }), left)
          assert.are.same({ "world", "test" }, right)
        end)
      end)
      it("creates a copy of the original set when concatenatng with nil", function()
        local set = Set.mk({ "hello", "world" })

        local concatenation_result = set + nil

        assert.are.same(Set.mk({ "hello", "world" }), concatenation_result)
        assert.are.same(Set.mk({ "hello", "world" }), set)
      end)
      describe("fails when concatenating with", function()
        it("a number", function()
          assert.has_error(function()
            local _ = Set.mk({ "hello", "world" }) .. 1
          end)
        end)
        it("a string", function()
          assert.has_error(function()
            local _ = Set.mk({ "hello", "world" }) .. "test"
          end)
        end)
        it("a boolean", function()
          assert.has_error(function()
            local _ = Set.mk({ "hello", "world" }) .. true
          end)
          assert.has_error(function()
            local _ = Set.mk({ "hello", "world" }) .. false
          end)
        end)
      end)
    end)
    describe(":size()", function()
      it("should return the number of elements in the set", function()
        local set = Set.mk({ "test", "hello", "world" })
        assert.are.equal(3, set:size())
      end)
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
    describe(":contains", function()
      it("returns true when an element is in the set and does not mutate the set", function()
        local key_to_search = "test"
        local set = Set.mk({ key_to_search, "hello" })
        local set_copy = Set.mk(set)

        assert.is_true(set:contains(key_to_search))

        assert.are.same(set_copy, set)
      end)
      it("returns false when an element is not in the set", function()
        local set = Set.mk({ "test", "hello" })
        local set_copy = Set.mk(set)

        assert.is_false(set:contains("world"))

        assert.are.same(set_copy, set)
      end)
    end)
    describe("()", function()
      it("returns true when an element is in the set and does not mutate the set", function()
        local key_to_search = "test"
        local set = Set.mk({ key_to_search, "hello" })
        local set_copy = Set.mk(set)

        assert.is_true(set(key_to_search))

        assert.are.same(set_copy, set)
      end)
      it("returns false when an element is not in the set", function()
        local set = Set.mk({ "test", "hello" })
        local set_copy = Set.mk(set)

        assert.is_false(set("world"))

        assert.are.same(set_copy, set)
      end)
    end)
    describe(":pairs()", function()
      it("enables to enumerate elements", function()
        assert.has_no.errors(function()
          local set = Set.mk({ "test", "hello", "world" })

          for e, v in set:pairs() do
            assert.is_true(set(e))
            assert.is_true(v)
          end
        end)
      end)
    end)
    describe(":ipairs()", function()
      it("enables to enumerate elements", function()
        assert.has_no.errors(function()
          local set = Set.mk({ "test", "hello", "world" })

          for i, e in set:ipairs() do
            assert.is_true(1 <= i)
            assert.is_true(i <= 3)
            assert.is_true(set(e))
          end
        end)
      end)
    end)
  end)
end)
