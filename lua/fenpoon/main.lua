local _2afile_2a = "fnl/fenpoon/main.fnl"
local _2amodule_name_2a = "fenpoon.main"
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
local a, nvim, path = require("fenpoon.aniseed.core"), require("fenpoon.aniseed.nvim"), require("plenary.path")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["path"] = path
local marks = {}
local function debug()
  return vim.inspect(marks)
end
_2amodule_2a["debug"] = debug
local function reset()
  marks = nil
  return nil
end
_2amodule_2a["reset"] = reset
local function project_root()
  return vim.loop.cwd()
end
_2amodule_2a["project-root"] = project_root
local function file_path()
  return vim.api.nvim_buf_get_name(0)
end
_2amodule_2a["file-path"] = file_path
local function cursor_location()
  return vim.api.nvim_win_get_cursor(0)
end
_2amodule_2a["cursor-location"] = cursor_location
local function mark_file()
  local file = file_path()
  local cursor = cursor_location()
  return table.insert(marks, {file, cursor})
end
_2amodule_2a["mark_file"] = mark_file
local function list_marks()
  local tbl_17_auto = {}
  local i_18_auto = #tbl_17_auto
  for i, _1_ in ipairs(marks) do
    local _each_2_ = _1_
    local file = _each_2_[1]
    local _ = _each_2_[2]
    local val_19_auto = {i, file}
    if (nil ~= val_19_auto) then
      i_18_auto = (i_18_auto + 1)
      do end (tbl_17_auto)[i_18_auto] = val_19_auto
    else
    end
  end
  return tbl_17_auto
end
_2amodule_2a["list_marks"] = list_marks
reset()
table.insert(marks, {"foo", {20, 30}})
table.insert(marks, {"bar", {40, 50}})
mark_file()
list_marks()
return _2amodule_2a