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
        assert.has_error(function() local _ = Set.mk(10) end)
      end)
      it("a string", function()
        assert.has_error(function() local _ = Set.mk("test") end)
      end)
      it("true", function()
        assert.has_error(function() local _ = Set.mk(true) end)
      end)
    end)
    it("should create a copy of a set if set is passed", function()
      local set = Set.mk({ "test" })
      local set_copy = Set.mk(set)

      assert.are.same(set, set_copy)
      assert.is_false(rawequal(set, set_copy))
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
      describe("creates a new set containing elements from the original set and", function()
        it("another set in both orders", function()
          local set1 = Set.mk({ "hello", "world" })
          local set2 = Set.mk({ "world", "test" })

          local actual1 = set1 + set2
          local actual2 = set2 + set1

          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual1)
          assert.are.same(expected, actual2)

          assert.are.same(Set.mk({ "hello", "world" }), set1)
          assert.are.same(Set.mk({ "world", "test" }), set2)
        end)
        it("a table of indexed elements in both orders", function()
          local left = Set.mk({ "hello", "world" })
          local right = { "world", "test" }

          local actual1 = left + right
          local actual2 = right + left

          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual1)
          assert.are.same(expected, actual2)

          assert.are.same(Set.mk({ "hello", "world" }), left)
          assert.are.same({ "world", "test" }, right)
        end)
        it("a number in both orders", function()
          local set = Set.mk({ "hello", "world" })

          local actual1 = set + 10
          local actual2 = 10 + set

          local expected = Set.mk({ "hello", "world", 10 })

          assert.are.same(expected, actual1)
          assert.are.same(expected, actual2)

          assert.are.same(Set.mk({ "hello", "world" }), set)
        end)
        it("a string in both orders", function()
          local set = Set.mk({ "hello", "world" })

          local actual1 = set + "test"
          local actual2 = "test" + set

          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual1)
          assert.are.same(expected, actual2)

          assert.are.same(Set.mk({ "hello", "world" }), set)
        end)
        it("a boolean in both orders", function()
          local set = Set.mk({ "hello", "world", true })

          local actual1 = (set + true) + false
          local actual2 = (false + set) + true
          local actual3 = true + (false + set)

          local expected = Set.mk({ "hello", "world", true, false })

          assert.are.same(expected, actual1)
          assert.are.same(expected, actual2)
          assert.are.same(expected, actual3)

          assert.are.same(Set.mk({ "hello", "world", true }), set)
        end)
        it("nil in both orders", function()
          local set = Set.mk({ "hello", "world", true })

          local actual1 = set + nil
          local actual2 = nil + set
          local expected = Set.mk({ "hello", "world", true })

          assert.are.same(expected, actual1)
          assert.are.same(expected, actual2)
          assert.are.same(Set.mk({ "hello", "world", true }), set)
        end)
      end)
    end)
    describe("-", function()
      describe("creates a new set that is the same as the original wihtout", function()
        it("the subtracted element", function()
          local set = Set.mk({ "test", "string1", 1, 2 })

          local subtraction_result = (set - "test") - 2

          assert.are.same(Set.mk({"string1", 1}), subtraction_result)

          assert.are.same(Set.mk({ "test", "string1", 1, 2 }), set)
        end)
        it("the subtracted elements of the table", function()
          local set = Set.mk({ "test", "string1", 1, 2 })

          local subtraction_result = set - { "test", 2 }

          assert.are.same(Set.mk({"string1", 1}), subtraction_result)

          assert.are.same(Set.mk({ "test", "string1", 1, 2 }), set)
        end)
        it("the subtracted elements of another set", function()
          local set = Set.mk({ "test", "string1", 1, 2 })

          local subtraction_result = set - Set.mk({ "test", 2 })

          assert.are.same(Set.mk({"string1", 1}), subtraction_result)

          assert.are.same(Set.mk({ "test", "string1", 1, 2 }), set)
        end)
      end)
      it("creates a new set that is the same as the original when subtracting nil", function()
        local set = Set.mk({ "test", "string1", 1, 2 })

        local subtraction_result = set - nil

        assert.are.same(Set.mk({ "test", "string1", 1, 2 }), subtraction_result)

        assert.are.same(Set.mk({ "test", "string1", 1, 2 }), set)
      end)
      describe("fails if set appears on the right and left is", function()
        it("a number", function()
          local set = Set.mk({ "test", "string1", 1, 2 })

          assert.has_error(function() local _ = 2 - set end)
        end)
        it("a string", function()
          local set = Set.mk({ "test", "string1", 1, 2 })

          assert.has_error(function() local _ = "test" - set end)
        end)
        it("a boolean", function()
          local set = Set.mk({ "test", "string1", 1, 2, true, false })

          assert.has_error(function() local _ = true - set end)
          assert.has_error(function() local _ = false - set end)
        end)
        it("a table", function()
          local set = Set.mk({ "test", "string1", 1, 2 })

          assert.has_error(function() local _ = { "test", 1 } - set end)
        end)
        it("nil", function()
          local set = Set.mk({ "test", "string1", 1, 2 })

          assert.has_error(function() local _ = nil - set end)
        end)
      end)
    end)
    describe("*", function()
      describe("should produce a new set containing elements that appear in both arguments at the same time when intersecting with", function()
        describe("another Set", function()
          it("that has some intersecting elements", function()
            local left = Set.mk({ "test", "string1", 1, 2 })
            local right = Set.mk({ "string1", 2 })

            local intersection_result1 = left * right
            local intersection_result2 = right * left

            assert.are.same(Set.mk({ "string1", 2 }), intersection_result1)
            assert.are.same(Set.mk({ "string1", 2 }), intersection_result2)

            assert.are.same(Set.mk({ "test", "string1", 1, 2 }), left)
            assert.are.same(Set.mk({ "string1", 2 }), right)
          end)
          it("that does not have any intersecting elements", function()
            local left = Set.mk({ "test", "string1", 1, 2 })
            local right = Set.mk({ "string2", 3 })

            local intersection_result1 = left * right
            local intersection_result2 = right * left

            assert.are.same(Set.mk(), intersection_result1)
            assert.are.same(Set.mk(), intersection_result2)

            assert.are.same(Set.mk({ "test", "string1", 1, 2 }), left)
            assert.are.same(Set.mk({ "string2", 3 }), right)
          end)
        end)
        describe("a table Int -> number", function()
          it("that has some intersecting elements", function()
            local left = Set.mk({ "test", "string1", 1, 2 })
            local right = { "string1", 2 }

            local intersection_result1 = left * right
            local intersection_result2 = right * left

            assert.are.same(Set.mk({ "string1", 2 }), intersection_result1)
            assert.are.same(Set.mk({ "string1", 2 }), intersection_result2)

            assert.are.same(Set.mk({ "test", "string1", 1, 2 }), left)
            assert.are.same({ "string1", 2 }, right)
          end)
          it("that does not have any intersecting elements", function()
            local left = Set.mk({ "test", "string1", 1, 2 })
            local right = { "string2", 3 }

            local intersection_result1 = left * right
            local intersection_result2 = right * left

            assert.are.same(Set.mk(), intersection_result1)
            assert.are.same(Set.mk(), intersection_result2)

            assert.are.same(Set.mk({ "test", "string1", 1, 2 }), left)
            assert.are.same({ "string2", 3 }, right)
          end)
        end)
      end)
      describe("should return the empty set when intersecting it with nil", function()
        local set = Set.mk({ "test", "string1", 1, 2 })

        local intersection_result1 = set * nil
        local intersection_result2 = nil * set

        assert.are.same(Set.mk(), intersection_result1)
        assert.are.same(Set.mk(), intersection_result2)

        assert.are.same(Set.mk({ "test", "string1", 1, 2 }), set)
      end)
      describe("fails when trying to intersecct with", function()
        it("a number", function()
          assert.has_error(function()
            local set = Set.mk({ "test", "string1", 1, 2 })
            local _ = set * 2
          end)
          assert.has_error(function()
            local set = Set.mk({ "test", "string1", 1, 2 })
            local _ =  2 * set
          end)
        end)
        it("a string", function()
          assert.has_error(function()
            local set = Set.mk({ "test", "string1", 1, 2 })
            local _ = set * "test"
          end)
          assert.has_error(function()
            local set = Set.mk({ "test", "string1", 1, 2 })
            local _ = "test" * set
          end)
        end)
        it("a boolean", function()
          assert.has_error(function()
            local set = Set.mk({ "test", "string1", 1, 2, true })
            local _ = set * true
          end)
          assert.has_error(function()
            local set = Set.mk({ "test", "string1", 1, 2, true })
            local _ = true * set
          end)
        end)
      end)
    end)
    describe("..", function()
      describe("creates a new set contating elements from the original set and", function()
        it("another set", function()
          local set1 = Set.mk({ "hello", "world" })
          local set2 = Set.mk({ "world", "test" })

          local actual1 = set1 .. set2
          local actual2 = set2 .. set1
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual1)
          assert.are.same(expected, actual2)

          assert.are.same(Set.mk({ "hello", "world" }), set1)
          assert.are.same(Set.mk({ "world", "test" }), set2)
        end)
        it("a table of indexed elements", function()
          local set1 = Set.mk({ "hello", "world" })
          local set2 = { "world", "test" }

          local actual1 = set1 .. set2
          local actual2 = set2 .. set1
          local expected = Set.mk({ "hello", "world", "test" })

          assert.are.same(expected, actual1)
          assert.are.same(expected, actual2)

          assert.are.same(Set.mk({ "hello", "world" }), set1)
          assert.are.same({ "world", "test" }, set2)
        end)
      end)
      it("creates a copy of the original set when concatenatng with nil", function()
        local set = Set.mk({ "hello", "world" })

        local concatenation_result1 = set + nil
        local concatenation_result2 = nil + set

        assert.are.same(Set.mk({ "hello", "world" }), concatenation_result1)
        assert.are.same(Set.mk({ "hello", "world" }), concatenation_result2)
        assert.are.same(Set.mk({ "hello", "world" }), set)
      end)
      describe("fails when concatenating with", function()
        it("a number", function()
          assert.has_error(function()
            local _ = Set.mk({ "hello", "world" }) .. 1
          end)
          assert.has_error(function()
            local _ = 1 .. Set.mk({ "hello", "world" })
          end)
        end)
        it("a string", function()
          assert.has_error(function()
            local _ = "test" .. Set.mk({ "hello", "world" })
          end)
        end)
        it("a boolean", function()
          assert.has_error(function()
            local _ = Set.mk({ "hello", "world" }) .. true
          end)
          assert.has_error(function()
            local _ = true .. Set.mk({ "hello", "world" })
          end)
          assert.has_error(function()
            local _ = Set.mk({ "hello", "world" }) .. false
          end)
          assert.has_error(function()
            local _ = false .. Set.mk({ "hello", "world" })
          end)
        end)
      end)
    end)
    describe(":size()", function()
      describe("should return the number of elements in", function()
        it("a new set", function()
          local set = Set.mk({ "test", "hello", "world", "test" })
          assert.are.equal(3, set:size())
        end)
        it("in a set after concatenating a set to a table", function()
          local set = Set.mk({ "test", "hello", "world", "test" }) + { "hello", "hello", "test", "foo", "bar" }
          assert.are.equal(5, set:size())
        end)
        it("in a set after concatenating 2 sets", function()
          local set = Set.mk({ "test", "hello", "world", "test" }) + Set.mk({ "hello", "hello", "test", "foo", "bar" })
          assert.are.equal(5, set:size())
        end)
        it("in a set after concatenating an element to a set", function()
          local set = Set.mk({ "test", "hello", "world", "test" }) + "test"
          assert.are.equal(3, set:size())
        end)
        it("in a set after subtracting a table from a set", function()
          local set = Set.mk({ "test", "hello", "world", "test" }) - { "hello", "hello", "test", "foo", "bar" }
          assert.are.equal(1, set:size())
        end)
        it("in a set after subtracting 2 sets", function()
          local set = Set.mk({ "test", "hello", "world", "test" }) - Set.mk({ "hello", "hello", "test", "foo", "bar" })
          assert.are.equal(1, set:size())
        end)
        it("in a set after subtracting an element from a set", function()
          local set = Set.mk({ "test", "hello", "world", "test" }) - "hello"
          assert.are.equal(2, set:size())
        end)
        -- TOOD: multiplication
        it("in a set after intersecting a set with another set", function()
          local set = Set.mk({ "test", "hello", "world", "test" }) * Set.mk({ "test", "world", "world", "foo", "foo" })
          assert.are.equal(2, set:size())
        end)
        it("in a set after intersecting a set with a table", function()
          local set = Set.mk({ "test", "hello", "world", "test" }) * { "test", "world", "world", "foo", "foo" }
          assert.are.equal(2, set:size())
        end)
      end)
    end)
    describe("<", function()
      describe("should return true", function()
        it("when comparing a non empty set with a superset", function()
          local subset = Set.mk({ "test", "hello" })
          local superset = Set.mk({ "test", "hello", "world" })

          assert.is_true(subset < superset)
        end)
        it("when comparing an empty set with another non empty set", function()
          local set = Set.mk({ "test", "hello", "world" })

          assert.is_true(Set.mk({}) < set)
        end)
      end)
      describe("should return false", function()
        describe("when comparing a non empty set with", function()
          it("a set that is a subset of the original", function()
            local subset = Set.mk({ "test", "hello" })
            local superset = Set.mk({ "test", "hello", "world" })

            assert.is_false(superset < subset)
          end)
          it("a set that is a disjoint set", function()
            local set1 = Set.mk({ "foo", "bar" })
            local set2 = Set.mk({ "test", "hello", "world" })

            assert.is_false(set1 < set2)
            assert.is_false(set2 < set1)
          end)
          it("an empty set", function()
            local set1 = Set.mk({ "foo", "bar" })

            assert.is_false(set1 < Set.mk({}))
          end)
          it("the same sets", function()
            local set1 = Set.mk({ "foo", "bar" })
            local set2 = Set.mk({ "foo", "bar" })

            assert.is_false(set1 < set1)
            assert.is_false(set1 < set2)
            assert.is_false(set2 < set1)
          end)
        end)
        it("when comparing 2 empty sets", function()
          assert.is_false(Set.mk({}) < Set.mk({}))
        end)
      end)
      describe("should fail when comparing with", function()
        it("table", function()
          assert.has_error(function()
            local set = Set.mk({ "foo", "bar" })
            local _ = set < {}
          end)
        end)
        it("number", function()
          assert.has_error(function()
            local set = Set.mk({ "foo", "bar" })
            local _ = set < 10
          end)
        end)
        it("boolean", function()
          assert.has_error(function()
            local set = Set.mk({ "foo", "bar" })
            local _ = set < true
          end)
          assert.has_error(function()
            local set = Set.mk({ "foo", "bar" })
            local _ = set < false
          end)
        end)
        it("nil", function()
          assert.has_error(function()
            local set = Set.mk({ "foo", "bar" })
            local _ = set < nil
          end)
        end)
      end)
    end)
    describe("<=", function()
      describe("should return true", function()
        it("when comparing a non empty set with a superset", function()
          local subset = Set.mk({ "test", "hello" })
          local superset = Set.mk({ "test", "hello", "world" })

          assert.is_true(subset <= superset)
        end)
        it("when comparing an empty set with another non empty set", function()
          local set = Set.mk({ "test", "hello", "world" })

          assert.is_true(Set.mk({}) <= set)
        end)
        it("the same sets", function()
          local set1 = Set.mk({ "foo", "bar" })
          local set2 = Set.mk({ "foo", "bar" })

          assert.is_true(set1 <= set1)
          assert.is_true(set1 <= set2)
          assert.is_true(set2 <= set1)
        end)
        it("when comparing 2 empty sets", function()
          assert.is_true(Set.mk({}) <= Set.mk({}))
        end)
      end)
      describe("should return false", function()
        describe("when comparing a non empty set with", function()
          it("a set that is a subset of the original", function()
            local subset = Set.mk({ "test", "hello" })
            local superset = Set.mk({ "test", "hello", "world" })

            assert.is_false(superset <= subset)
          end)
          it("a set that is a disjoint set", function()
            local set1 = Set.mk({ "foo", "bar" })
            local set2 = Set.mk({ "test", "hello", "world" })

            assert.is_false(set1 <= set2)
            assert.is_false(set2 <= set1)
          end)
          it("an empty set", function()
            local set1 = Set.mk({ "foo", "bar" })

            assert.is_false(set1 <= Set.mk({}))
          end)
        end)
      end)
      describe("should fail when comparing with", function()
        it("a table", function()
          local set = Set.mk({ "foo", "bar" })

          assert.has_error(function() local _ = set <= {} end)
        end)
        it("a number", function()
          local set = Set.mk({ "foo", "bar" })

          assert.has_error(function() local _ = set <= 10 end)
        end)
        it("a boolean", function()
          local set = Set.mk({ "foo", "bar" })

          assert.has_error(function() local _ = set <= true end)
          assert.has_error(function() local _ = set <= false end)
        end)
        it("nil", function()
          local set = Set.mk({ "foo", "bar" })

          assert.has_error(function() local _ = set <= nil end)
        end)
      end)
    end)
    describe("==", function()
      describe("should return true", function()
        it("the same sets", function()
          local set1 = Set.mk({ "foo", "bar" })
          local set2 = Set.mk({ "foo", "bar" })

          assert.is_true(set1 == set1)
          assert.is_true(set1 == set2)
          assert.is_true(set2 == set1)
        end)
        it("when comparing 2 empty sets", function()
          assert.is_true(Set.mk({}) == Set.mk({}))
        end)
      end)
      describe("should return false", function()
        describe("when comparing a non empty set with", function()
          it("with a superset", function()
            local subset = Set.mk({ "test", "hello" })
            local superset = Set.mk({ "test", "hello", "world" })

            assert.is_false(subset == superset)
          end)
          it("a set that is a disjoint set", function()
            local set1 = Set.mk({ "foo", "bar" })
            local set2 = Set.mk({ "test", "hello", "world" })

            assert.is_false(set1 == set2)
            assert.is_false(set2 == set1)
          end)
          it("an empty set", function()
            local set1 = Set.mk({ "foo", "bar" })

            assert.is_false(set1 == Set.mk({}))
          end)
        end)
        it("a table", function()
          local set = Set.mk({ "foo", "bar" })
          assert.is_false(set == {})
        end)
        it("a number", function()
          local set = Set.mk({ "foo", "bar" })
          assert.is_false(set == 10)
        end)
        it("a boolean", function()
          local set = Set.mk({ "foo", "bar" })
          assert.is_false(set == true)
          assert.is_false(set == false)
        end)
        it("nil", function()
          local set = Set.mk({ "foo", "bar" })
          assert.is_false(set == nil)
        end)
      end)
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
