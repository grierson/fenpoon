local _2afile_2a = "fnl/fenpoon/api.fnl"
local _2amodule_name_2a = "fenpoon.api"
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
local a, actions_state, cache, core, finders, nvim, pickers, themes = require("fenpoon.aniseed.core"), require("telescope.actions.state"), require("fenpoon.cache"), require("fenpoon.core"), require("telescope.finders"), require("fenpoon.aniseed.nvim"), require("telescope.pickers"), require("telescope.themes")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["actions-state"] = actions_state
_2amodule_locals_2a["cache"] = cache
_2amodule_locals_2a["core"] = core
_2amodule_locals_2a["finders"] = finders
_2amodule_locals_2a["nvim"] = nvim
_2amodule_locals_2a["pickers"] = pickers
_2amodule_locals_2a["themes"] = themes
local MARKS = {}
local function init()
  MARKS = cache.read()
  return nil
end
_2amodule_2a["init"] = init
local function file_path()
  return nvim.buf_get_name(0)
end
_2amodule_locals_2a["file-path"] = file_path
local function debug()
  if a["empty?"](MARKS) then
    return print("No marks")
  else
    return print(core.print(MARKS))
  end
end
_2amodule_2a["debug"] = debug
local function mark()
  core.add(MARKS, file_path())
  return cache.write(MARKS)
end
_2amodule_2a["mark"] = mark
local function select(id)
  if core.contains(core["get-ids"](), id) then
    local file = a.get(core["find-mark-by-id"](MARKS, id), "file")
    local bufid = nvim.fn.bufadd(file)
    return nvim.set_current_buf(bufid)
  else
    return print(a.str("No ", id, " mark"))
  end
end
_2amodule_2a["select"] = select
local function make_finder(marks)
  return finders.new_table({results = marks, entry_maker = core["entry-maker"]})
end
_2amodule_2a["make-finder"] = make_finder
local function telescope_delete_mark(prompt_bufnr)
  local confirmation = nvim.fn.input("Delete? [y/n]: ")
  local _let_3_ = actions_state.get_selected_entry()
  local index = _let_3_["index"]
  if (string.len(confirmation) == 0) then
    return print("Didn't delete mark")
  else
    core.remove(MARKS, index)
    cache.write(MARKS)
    local current_picker = actions_state.get_current_picker(prompt_bufnr)
    return current_picker:refresh(make_finder(MARKS), {reset_prompt = true})
  end
end
_2amodule_locals_2a["telescope-delete-mark"] = telescope_delete_mark
local function telescope(opts)
  if a["empty?"](MARKS) then
    return print("No marks")
  else
    local function _5_(_, map)
      map("i", "<c-d>", telescope_delete_mark)
      map("n", "<c-d>", telescope_delete_mark)
      return true
    end
    return pickers.new(themes.get_dropdown(), {prompt_title = "Fenpoon", finder = make_finder(MARKS), attach_mappings = _5_}):find()
  end
end
_2amodule_2a["telescope"] = telescope
return _2amodule_2a