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
local function contains(coll, target)
  local function _1_(v)
    if (v == target) then
      return v
    else
      return nil
    end
  end
  return a.some(_1_, coll)
end
_2amodule_locals_2a["contains"] = contains
local function table__3etuples(coll)
  local function _3_(x)
    return x
  end
  return a["map-indexed"](_3_, coll)
end
_2amodule_2a["table->tuples"] = table__3etuples
local function next_id(current_ids, target)
  local target0 = (target or 1)
  if contains(current_ids, target0) then
    return next_id(current_ids, a.inc(target0))
  else
    return target0
  end
end
_2amodule_2a["next-id"] = next_id
local function add(marks, file)
  if contains(a.vals(marks), file) then
    return marks
  else
    return a.assoc(marks, next_id(a.keys(marks)), file)
  end
end
_2amodule_2a["add"] = add
local function remove(marks, id)
  return a.assoc(marks, id, nil)
end
_2amodule_2a["remove"] = remove
local function list(marks)
  local function _6_()
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
  return str.join("\n", _6_())
end
_2amodule_2a["list"] = list
local function relative_path(proj, file)
  return string.gsub(file, proj, "")
end
_2amodule_2a["relative-path"] = relative_path
return _2amodule_2a