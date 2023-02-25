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
local nvim = require("aniseed.nvim")
do end (_2amodule_locals_2a)["nvim"] = nvim
local marks = {}
local function debug()
  return print(vim.inspect(marks))
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
local function mark(state)
  local file = file_path()
  local cursor = cursor_location()
  do end (state)[file] = cursor
  return state
end
_2amodule_2a["mark"] = mark
return _2amodule_2a