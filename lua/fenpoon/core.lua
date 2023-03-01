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
_2amodule_2a["contains"] = contains
local function find_mark_by_id(coll, target_id)
  for i, v in ipairs(coll) do
    local _let_3_ = v
    local id = _let_3_["id"]
    if (id == target_id) then
      return v
    else
    end
  end
  return nil
end
_2amodule_2a["find-mark-by-id"] = find_mark_by_id
local function find_mark_index_by_id(coll, target_id)
  for i, _5_ in ipairs(coll) do
    local _each_6_ = _5_
    local id = _each_6_["id"]
    if (id == target_id) then
      return i
    else
    end
  end
  return nil
end
_2amodule_2a["find-mark-index-by-id"] = find_mark_index_by_id
local function next_id(current_ids, _3ftarget)
  local target = (_3ftarget or 1)
  if contains(current_ids, target) then
    return next_id(current_ids, a.inc(target))
  else
    return target
  end
end
_2amodule_2a["next-id"] = next_id
local function add(marks, file)
  local function _11_(_9_)
    local _arg_10_ = _9_
    local file0 = _arg_10_["file"]
    return file0
  end
  if contains(a.map(_11_, marks), file) then
    return marks
  else
    local id
    local function _14_(_12_)
      local _arg_13_ = _12_
      local id0 = _arg_13_["id"]
      return id0
    end
    id = next_id(a.map(_14_, marks))
    return table.insert(marks, {id = id, file = file})
  end
end
_2amodule_2a["add"] = add
local function remove(marks, id)
  local mark_index = find_mark_index_by_id(marks, id)
  return table.remove(marks, mark_index)
end
_2amodule_2a["remove"] = remove
local function list(marks)
  local function _16_()
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
  return str.join("\n", _16_())
end
_2amodule_2a["list"] = list
local function relative_path(proj, file)
  return string.gsub(file, proj, "")
end
_2amodule_2a["relative-path"] = relative_path
return _2amodule_2a