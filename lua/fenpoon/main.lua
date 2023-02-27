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
local a, actions, actions_state, core, finders, nvim, pickers, str, themes = require("fenpoon.aniseed.core"), require("telescope.actions"), require("telescope.actions.state"), require("fenpoon.core"), require("telescope.finders"), require("fenpoon.aniseed.nvim"), require("telescope.pickers"), require("fenpoon.aniseed.string"), require("telescope.themes")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["actions"] = actions
_2amodule_locals_2a["actions-state"] = actions_state
_2amodule_locals_2a["core"] = core
_2amodule_locals_2a["finders"] = finders
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["pickers"] = pickers
_2amodule_locals_2a["str"] = str
_2amodule_locals_2a["themes"] = themes
local marks = {}
local function init()
  return true
end
_2amodule_2a["init"] = init
local function project_path()
  return vim.loop.cwd()
end
_2amodule_2a["project-path"] = project_path
local function file_path()
  return vim.api.nvim_buf_get_name(0)
end
_2amodule_2a["file-path"] = file_path
local function path__3ebufid(path)
  return vim.fn.bufadd(path)
end
_2amodule_locals_2a["path->bufid"] = path__3ebufid
local function entry_maker_fn(_1_)
  local _arg_2_ = _1_
  local i = _arg_2_[1]
  local file = _arg_2_[2]
  return {value = file, ordinal = i, display = a.str(i, " - ", core["relative-path"](project_path(), file)), filename = file}
end
_2amodule_locals_2a["entry-maker-fn"] = entry_maker_fn
local function make_finder()
  return finders.new_table({results = core["table->tuples"](marks), entry_maker = entry_maker_fn})
end
_2amodule_locals_2a["make-finder"] = make_finder
local function debug()
  if a["empty?"](marks) then
    return print("No marks")
  else
    return print(core.list(marks))
  end
end
_2amodule_2a["debug"] = debug
local function mark()
  return core.add(marks, file_path())
end
_2amodule_2a["mark"] = mark
local function delete(index)
  return core.remove(marks, index)
end
_2amodule_2a["delete"] = delete
local function delete_mark(prompt_bufnr)
  local confirmation = vim.fn.input("Delete? [y/n]: ")
  local _let_4_ = actions_state.get_selected_entry()
  local index = _let_4_["index"]
  if (string.len(confirmation) == 0) then
    return print("Didn't delete mark")
  else
    delete(index)
    local current_picker = actions_state.get_current_picker(prompt_bufnr)
    return current_picker:refresh(make_finder(), {reset_prompt = true})
  end
end
_2amodule_2a["delete-mark"] = delete_mark
local function select(index)
  if core.contains(a.keys(marks), index) then
    local name = a.get(marks, index)
    local bufid = path__3ebufid(name)
    return vim.api.nvim_set_current_buf(bufid)
  else
    return print(a.str("No ", index, " mark"))
  end
end
_2amodule_2a["select"] = select
local function telescope(opts)
  if a["empty?"](marks) then
    return print("No marks")
  else
    local function _7_(_, map)
      map("i", "<c-d>", delete_mark)
      map("n", "<c-d>", delete_mark)
      return true
    end
    return pickers.new(themes.get_dropdown(), {finder = make_finder(), prompt_title = "Fenpoon", attach_mappings = _7_}):find()
  end
end
_2amodule_2a["telescope"] = telescope
return _2amodule_2a