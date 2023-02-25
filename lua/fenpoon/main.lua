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
local a, core, nvim = require("fenpoon.aniseed.core"), require("fenpoon.core"), require("fenpoon.aniseed.nvim")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["core"] = core
_2amodule_locals_2a["nvim"] = nvim
local marks = {}
local function get_path()
  return vim.api.nvim_buf_get_name(0)
end
_2amodule_2a["get-path"] = get_path
local function cursor_location()
  return vim.api.nvim_win_get_cursor(0)
end
_2amodule_2a["cursor-location"] = cursor_location
local function mark()
  return core.add(marks, get_path(), cursor_location())
end
_2amodule_2a["mark"] = mark
local function path__3ebufid(path)
  return vim.fn.bufadd(path)
end
_2amodule_2a["path->bufid"] = path__3ebufid
local function swap(bufid)
  return vim.api.nvim_set_current_buf(bufid)
end
_2amodule_2a["swap"] = swap
local function init()
  return print("hello fenpoon")
end
_2amodule_2a["init"] = init
local function log()
  return print(core.list(marks))
end
_2amodule_2a["log"] = log
local function select(index)
  return core.get(marks, index)
end
_2amodule_2a["select"] = select
return _2amodule_2a