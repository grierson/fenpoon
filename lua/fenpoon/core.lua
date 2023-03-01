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
local function get_ids(marks)
  local function _5_(_3_)
    local _arg_4_ = _3_
    local id = _arg_4_["id"]
    return id
  end
  return a.map(_5_, marks)
end
_2amodule_2a["get-ids"] = get_ids
local function get_files(marks)
  local function _8_(_6_)
    local _arg_7_ = _6_
    local file = _arg_7_["file"]
    return file
  end
  return a.map(_8_, marks)
end
_2amodule_2a["get-files"] = get_files
local function find_mark_by_id(marks, target_id)
  for i, v in ipairs(marks) do
    local _let_9_ = v
    local id = _let_9_["id"]
    if (id == target_id) then
      return v
    else
    end
  end
  return nil
end
_2amodule_2a["find-mark-by-id"] = find_mark_by_id
local function find_mark_index_by_id(marks, target_id)
  for i, _11_ in ipairs(marks) do
    local _each_12_ = _11_
    local id = _each_12_["id"]
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
local function print(marks)
  local function _15_()
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
  return str.join("\n", _15_())
end
_2amodule_2a["print"] = print
local function relative_path(proj, file)
  local x = string.gsub(file, proj, "")
  return x
end
_2amodule_2a["relative-path"] = relative_path
local function add(marks, file)
  if contains(get_files(marks), file) then
    return marks
  else
    local id = next_id(get_ids(marks))
    return table.insert(marks, {id = id, file = file})
  end
end
_2amodule_2a["add"] = add
local function remove(marks, id)
  local mark_index = find_mark_index_by_id(marks, id)
  return table.remove(marks, mark_index)
end
_2amodule_2a["remove"] = remove
return _2amodule_2a