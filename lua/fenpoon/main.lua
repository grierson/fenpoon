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
local a, actions, actions_state, builtin, conf, core, finders, nvim, pickers, str, themes = require("fenpoon.aniseed.core"), require("telescope.actions"), require("telescope.actions.state"), require("telescope.builtin"), require("telescope.config"), require("fenpoon.core"), require("telescope.finders"), require("fenpoon.aniseed.nvim"), require("telescope.pickers"), require("fenpoon.aniseed.string"), require("telescope.themes")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["actions"] = actions
_2amodule_locals_2a["actions-state"] = actions_state
_2amodule_locals_2a["builtin"] = builtin
_2amodule_locals_2a["conf"] = conf
_2amodule_locals_2a["core"] = core
_2amodule_locals_2a["finders"] = finders
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["pickers"] = pickers
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["themes"] = themes
local marks = {}
local function init()
  return print("hello fenpoon")
end
_2amodule_2a["init"] = init
local function get_path()
  return vim.api.nvim_buf_get_name(0)
end
_2amodule_2a["get-path"] = get_path
local function mark()
  return core.add(marks, get_path())
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
local function log()
  if a["empty?"](marks) then
    return print("No marks")
  else
    return print(str.join("\n", core.list(marks)))
  end
end
_2amodule_2a["log"] = log
local function select(index)
  local name = core.get(marks, index)
  local bufid = path__3ebufid(name)
  return swap(bufid)
end
_2amodule_2a["select"] = select
local function telescope(opts)
  if a["empty?"](marks) then
    return print("No marks")
  else
    return pickers.new(themes.get_dropdown(), {finder = finders.new_table({results = core.list(marks)}), prompt_title = "Fenpoon"}):find()
  end
end
_2amodule_2a["telescope"] = telescope
return _2amodule_2a