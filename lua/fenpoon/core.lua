-- [nfnl] Compiled from fnl/fenpoon/core.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local str = autoload("nfnl.string")
local function contains(coll, target)
  local function _2_(v)
    if (v == target) then
      return v
    else
      return nil
    end
  end
  return core.some(_2_, coll)
end
local function project_path()
  return vim.loop.cwd()
end
local function get_ids(marks)
  local function _6_(_4_)
    local _arg_5_ = _4_
    local id = _arg_5_["id"]
    return id
  end
  return core.map(_6_, marks)
end
local function get_files(marks)
  local function _9_(_7_)
    local _arg_8_ = _7_
    local file = _arg_8_["file"]
    return file
  end
  return core.map(_9_, marks)
end
local function find_mark_by_id(marks, target_id)
  for i, v in ipairs(marks) do
    local _let_10_ = v
    local id = _let_10_["id"]
    if (id == target_id) then
      return v
    else
    end
  end
  return nil
end
local function find_mark_index_by_id(marks, target_id)
  for i, _12_ in ipairs(marks) do
    local _each_13_ = _12_
    local id = _each_13_["id"]
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
  local function _16_()
    local tbl_91_auto = {}
    local i_92_auto = #tbl_91_auto
    for i, file in pairs(marks) do
      local val_93_auto = core.str(i, " - ", file)
      if (nil ~= val_93_auto) then
        i_92_auto = (i_92_auto + 1)
        do end (tbl_91_auto)[i_92_auto] = val_93_auto
      else
      end
    end
    return tbl_91_auto
  end
  return str.join("\n", _16_())
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
  local x = string.gsub(file, proj, "")
  return x
end
local function entry_maker(_19_)
  local _arg_20_ = _19_
  local id = _arg_20_["id"]
  local file = _arg_20_["file"]
  return {value = file, ordinal = file, display = core.str(id, " - ", relative_path(project_path(), file)), filename = file}
end
return entry_maker
