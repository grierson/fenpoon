local _2afile_2a = "fnl/fenpoon/core.fnl"
local _2amodule_name_2a = "fenpoon.core"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local a = require("fenpoon.aniseed.core")
do end (_2amodule_locals_2a)["a"] = a
local function contains(marks, target)
  local function _3_(_1_)
    local _arg_2_ = _1_
    local path = _arg_2_[1]
    local _ = _arg_2_[2]
    if (path == target) then
      return path
    else
      return nil
    end
  end
  return a.some(_3_, marks)
end
_2amodule_locals_2a["contains"] = contains
local function add(state, path, cursor)
  if a["nil?"](contains(state, path)) then
    return table.insert(state, {path, cursor})
  else
    return nil
  end
end
_2amodule_2a["add"] = add
local function list(state)
  local tbl_17_auto = {}
  local i_18_auto = #tbl_17_auto
  for i, _6_ in ipairs(state) do
    local _each_7_ = _6_
    local file = _each_7_[1]
    local _each_8_ = _each_7_[2]
    local row = _each_8_[1]
    local col = _each_8_[2]
    local val_19_auto = {i, (file .. ":" .. row .. ":" .. col)}
    if (nil ~= val_19_auto) then
      i_18_auto = (i_18_auto + 1)
      do end (tbl_17_auto)[i_18_auto] = val_19_auto
    else
    end
  end
  return tbl_17_auto
end
_2amodule_2a["list"] = list
return _2amodule_2a