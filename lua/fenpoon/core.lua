-- [nfnl] Compiled from fnl/fenpoon/core.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local str = require("nfnl.string")
local function contains(coll, target)
  local function _1_(v)
    if (v == target) then
      return v
    else
      return nil
    end
  end
  return nfnl.some(_1_, coll)
end
local function get_files(marks)
  local function _5_(_3_)
    local _arg_4_ = _3_
    local file = _arg_4_["file"]
    return file
  end
  return nfnl.map(_5_, marks)
end
local function relative_path(proj, file)
  return nfnl.second(str.split(proj, file))
end
relative_path("proj/foo", "proj/foo/bar.fnl")
if (nil == nil) then
else
end
local function project_path()
  return vim.loop.cwd()
end
local function add(state, file_path, _3fproj_path)
  local proj = (_3fproj_path or project_path())
  local file = relative_path(proj, file_path)
  local marks
  do
    local t_7_ = state
    if (nil ~= t_7_) then
      t_7_ = (t_7_)[proj]
    else
    end
    marks = t_7_
  end
  if (marks == nil) then
    state[proj] = {{id = 1, file = file}}
    return state
  else
    local files = get_files(marks)
    if contains(files, file) then
      return state
    else
      table.insert(marks, {id = 1, file = file})
      return state
    end
  end
end
local function remove(marks, target)
  local function _11_(v)
    if (v ~= target) then
      return v
    else
      return nil
    end
  end
  return nfnl.filter(_11_, marks)
end
local function relative_path0(proj, file)
  return nfnl.second(str.split(file, proj))
end
local function entry_maker(file)
  return {value = file, ordinal = file, display = relative_path0(project_path(), file), filename = file}
end
return {contains = contains, add = add, remove = remove}
