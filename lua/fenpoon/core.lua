-- [nfnl] Compiled from fnl/fenpoon/core.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local utils = require("fenpoon.utils")
local function get_files(marks)
  local function _3_(_1_)
    local _arg_2_ = _1_
    local file = _arg_2_["file"]
    return file
  end
  return nfnl.map(_3_, marks)
end
local function get_ids(marks)
  local function _6_(_4_)
    local _arg_5_ = _4_
    local id = _arg_5_["id"]
    return id
  end
  return nfnl.map(_6_, marks)
end
local function get_mark_by_id(marks, target)
  local mark
  local function _9_(_7_)
    local _arg_8_ = _7_
    local id = _arg_8_["id"]
    return (id == target)
  end
  mark = nfnl.filter(_9_, marks)
  if not nfnl["empty?"](mark) then
    return nfnl.first(mark)
  else
    return nil
  end
end
local function next_id(current_ids, _3ftarget)
  local target = (_3ftarget or 1)
  if utils.contains(current_ids, target) then
    return next_id(current_ids, nfnl.inc(target))
  else
    return target
  end
end
local function add(state, file_path, _3fproj_path)
  local proj = (_3fproj_path or utils["project-path"]())
  local file = utils["normalize-path"](file_path, proj)
  local marks
  do
    local t_12_ = state
    if (nil ~= t_12_) then
      t_12_ = (t_12_)[proj]
    else
    end
    marks = t_12_
  end
  if (marks == nil) then
    state[proj] = {{id = 1, file = file}}
    return state
  else
    local files = get_files(marks)
    if utils.contains(files, file) then
      return state
    else
      local ids = get_ids(marks)
      local id = next_id(ids)
      table.insert(marks, {id = id, file = file})
      return state
    end
  end
end
local function remove_mark(target_id, marks)
  local function _18_(_16_)
    local _arg_17_ = _16_
    local id = _arg_17_["id"]
    return (id ~= target_id)
  end
  return nfnl.filter(_18_, marks)
end
local function remove(state, target_id, _3fproj_path)
  local proj = (_3fproj_path or utils["project-path"]())
  local function _19_(...)
    return remove_mark(target_id, ...)
  end
  return nfnl.update(state, proj, _19_)
end
return {add = add, remove = remove, ["get-mark-by-id"] = get_mark_by_id}
