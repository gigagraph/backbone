local SetM = {}

local _set_mt = {
  __metatable = "BkbSet"
}

SetM._set_mt = _set_mt

function SetM:is_set()
  return getmetatable(self) == _set_mt.__metatable
end

function SetM:contains(value)
  return self(value)
end

-- This function mutates the state of the current set. If it returns an error and the arument is a table, the state may be corrupted.
local function _concat_sets_in_place(set, other)
  if SetM.is_set(other) then
    for k, _ in pairs(other._data) do
      set._data[k] = true
    end
  elseif type(other) == "table" then
    for k, e in pairs(other) do
      if type(k) == "number" then
        set._data[e] = true
      else
        error(
          [[When concatenating a table, the table must be of type number -> Any.
          However, there is an entry with key "]]
          .. k .. [[" of type "]] .. type(k) .. [["]]
        )
      end
    end
  else
    error("Can only concat either a table number -> Any or another Set.")
  end
end

function _set_mt.__add(left, right)
  local copy = SetM.mk(left)

  concat_success, result = pcall(_concat_sets_in_place, copy, right)

  if not concat_success then
    if type(right) ~= "table" then
      copy._data[right] = true
    else
      error(result)
    end
  end

  return copy
end

function _set_mt.__sub(left, right)
  -- TODO
  -- right can be either another set or an element
end

function _set_mt.__mul(left, right)
  -- TODO
  -- right can only be a set
end

function _set_mt.__concat(left, right)
  local copy = SetM.mk(left)
  return copy._concat_sets_in_place(right)
end

function _set_mt:__len()
  return #(self._data)
end

function _set_mt.__lt(left, right)
  for e, _ in pairs(left._data) do
    -- If there exists and element in the left that does not exist in the right, then left is not a subset of right
    if right[e] ~= true then
      return false
    end
  end
end

function _set_mt.__le(left, right)
  -- < is the same as <= for sets because if a set is a proper subset of another, then it is definitely a subset of another set
  return left < right
end

function _set_mt.__eq(left, right)
  if #(left._data) ~= #(right._data) then
    return false
  else
    -- Since the lengths are the same, if left is a subset of the right, then left is the same set as right
    return left < right
  end
end

_set_mt.__index = SetM

function _set_mt:__newindex(key, value)
  if value == true then
    self._data[key] = true
  else
    error("The Set can only assign elements to `true`.")
  end
end

function _set_mt:__call(e)
  return self._data[e] or false
end

local function mk_empty_set()
  local set = { _data = {} }
  setmetatable(set, _set_mt)
  return set
end

SetM._mk_empty_set = mk_empty_set

function SetM.mk(es)
  local es = es or {}

  local set = mk_empty_set()
  _concat_sets_in_place(set, es)
  return set
end

return SetM
