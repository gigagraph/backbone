local SetM = {}

local _set_mt = {
  __metatable = "BkbSet"
}

SetM._set_mt = _set_mt

function SetM:is_set()
  return getmetatable(self) == _set_mt.__metatable
end

function SetM:size()
  -- TODO: performance improvement - store this in the data structure itself
  local size = 0
  for _, _ in self:pairs() do
    size = size + 1
  end
  return size
end

function SetM:contains(value)
  return self(value)
end

function SetM:pairs()
  return pairs(self._data)
end

function SetM:ipairs()
  return ipairs(self._data)
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
          .. k .. '" of type "' .. type(k) .. '"'
        )
      end
    end
  elseif type(other) == "nil" then
    -- skip
  else
    error("Can only concat either a table number -> Any, another Set, or nil.")
  end
end

function _set_mt.__add(left, right)
  local set = nil
  local maybe_set = nil

  if SetM.is_set(left) then
    set = left
    maybe_set = right
  else
    set = right
    maybe_set = left
  end

  local copy = SetM.mk(set)

  concat_success, result = pcall(_concat_sets_in_place, copy, maybe_set)

  if not concat_success then
    if type(maybe_set) ~= "table" then
      copy._data[maybe_set] = true
    else
      error(result)
    end
  end

  return copy
end

function _set_mt.__sub(left, right)
  if SetM.is_set(left) then
    local copy = SetM.mk(left)

    if SetM.is_set(right) then
      for k, _ in pairs(right._data) do
        copy._data[k] = nil
      end
    elseif type(right) == "table" then
      for k, e in pairs(right) do
        if type(k) == "number" then
          copy._data[e] = nil
        else
          error(
            [[When concatenating a table, the table must be of type number -> Any.
          However, there is an entry with key "]]
            .. k .. [[" of type "]] .. type(k) .. [["]]
          )
        end
      end
    else
      if right then
        copy._data[right] = nil
      end
    end

    return copy
  else
    error("When subtracting with a Set, the Set must be on the left side of the operation")
  end
end

function _set_mt.__mul(left, right)
  local set = nil
  local other = nil

  if SetM.is_set(left) then
    set = left
    other = right
  else
    set = right
    other = left
  end

  if type(other) == "table" then
    other = SetM.mk(other)
  end

  if SetM.is_set(other) then
    local smaller_set = nil
    local larger_set = nil

    if set:size() <= other:size() then
      smaller_set, larger_set = set, other
    else
      smaller_set, larger_set = other, set
    end

    local result = {}

    for e, _ in smaller_set:pairs() do
      if larger_set(e) then
        table.insert(result, e)
      end
    end

    return SetM.mk(result)
  elseif type(other) == "nil" then
    return SetM.mk()
  else
    error("Can only intersect either a table number -> Any or another Set.")
  end
end

function _set_mt.__concat(left, right)
  local set = nil
  local maybe_set = nil

  if SetM.is_set(left) then
    set = left
    maybe_set = right
  else
    set = right
    maybe_set = left
  end

  local copy = SetM.mk(set)
  _concat_sets_in_place(copy, maybe_set)
  return copy
end

function _set_mt.__lt(left, right)
  if SetM.is_set(left) and SetM.is_set(right) then
    return not (left:size() == right:size()) and left <= right
  else
    error("The proper subset operator can only be applied to Set-s")
  end
end

function _set_mt.__le(left, right)
  if SetM.is_set(left) and SetM.is_set(right) then
    for e, _ in pairs(left._data) do
      -- If there exists and element in the left that does not exist in the right, then left is not a subset of right
      if not right(e) then
        return false
      end
    end
    return true
  else
    error("A Set can only be compared to another Set")
  end
end

function _set_mt.__eq(left, right)
  if SetM.is_set(left) and SetM.is_set(right) then
    return (left:size() == right:size()) and left <= right
  else
    error("A Set can only be compared to another Set")
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
  local set = {
    _data = {},
    -- _size = 0, -- TODO: implement size
  }
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
