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
local a, str = require("fenpoon.aniseed.core"), require("fenpoon.aniseed.string")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["str"] = str
local function contains(marks, target)
  local function _1_(path)
    if (path == target) then
      return path
    else
      return nil
    end
  end
  return a.some(_1_, marks)
end
_2amodule_locals_2a["contains"] = contains
local function add(marks, path)
  if a["nil?"](contains(marks, path)) then
    return table.insert(marks, path)
  else
    return nil
  end
end
_2amodule_2a["add"] = add
local function list(marks)
  local function _4_()
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for i, file in pairs(marks) do
      local val_19_auto = a.str(i, " - ", file)
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    return tbl_17_auto
  end
  return str.join("\n", _4_())
end
_2amodule_2a["list"] = list
local function get(marks, index)
  return a.get(marks, index)
end
_2amodule_2a["get"] = get
return _2amodule_2a