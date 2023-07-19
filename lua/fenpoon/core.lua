-- [nfnl] Compiled from fnl/fenpoon/core.fnl by https://github.com/Olical/nfnl, do not edit.
local core = require("nfnl.core")
local str = require("nfnl.string")
local function contains(coll, target)
  local function _1_(v)
    if (v == target) then
      return v
    else
      return nil
    end
  end
  return core.some(_1_, coll)
end
local function project_path()
  return vim.loop.cwd()
end
local function get_ids(marks)
  local function _5_(_3_)
    local _arg_4_ = _3_
    local id = _arg_4_["id"]
    return id
  end
  return core.map(_5_, marks)
end
local function get_files(marks)
  local function _8_(_6_)
    local _arg_7_ = _6_
    local file = _arg_7_["file"]
    return file
  end
  return core.map(_8_, marks)
end
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
local function next_id(current_ids, _3ftarget)
  local target = (_3ftarget or 1)
  if contains(current_ids, target) then
    return next_id(current_ids, core.inc(target))
  else
    return target
  end
end
local function print(marks)
  local function _15_()
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for i, file in pairs(marks) do
      local val_19_auto = core.str(i, " - ", file)
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
local function add(marks, file)
  if contains(get_files(marks), file) then
    return marks
  else
    local id = next_id(get_ids(marks))
    return table.insert(marks, {id = id, file = file})
  end
end
local function remove(marks, id)
  local mark_index = find_mark_index_by_id(marks, id)
  return table.remove(marks, mark_index)
end
local function relative_path(proj, file)
  return core.second(str.split(proj, file))
end
local function entry_maker(_18_)
  local _arg_19_ = _18_
  local id = _arg_19_["id"]
  local file = _arg_19_["file"]
  return {value = file, ordinal = file, display = (id .. " - " .. relative_path(project_path(), file)), filename = file}
end
return {["find-mark-by-id"] = find_mark_by_id, contains = contains}
