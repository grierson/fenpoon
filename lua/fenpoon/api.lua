-- [nfnl] Compiled from fnl/fenpoon/api.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local nvim = autoload("nfnl.nvim")
local fenpoon = autoload("fenpoon.core")
local cache = autoload("fenpoon.cache")
local themes = autoload("telescope.themes")
local actions_state = autoload("telescope.actions.state")
local pickers = autoload("telescope.pickers")
local finders = autoload("telescope.finders")
local conf = autoload("telescope.config")
local MARKS = {}
local function setup()
  MARKS = cache.read()
  return nil
end
local function file_path()
  return nvim.buf_get_name(0)
end
local function debug()
  if core["empty?"](MARKS) then
    return print("No marks")
  else
    return print(fenpoon.print(MARKS))
  end
end
local function mark()
  local file = file_path()
  if not core["empty?"](file) then
    fenpoon.add(MARKS, file)
    return cache.write(MARKS)
  else
    return nil
  end
end
local function select(id)
  if fenpoon.contains(fenpoon["get-ids"](MARKS), id) then
    local file = core.get(fenpoon["find-mark-by-id"](MARKS, id), "file")
    local bufid = nvim.fn.bufadd(file)
    return nvim.set_current_buf(bufid)
  else
    return print(core.str("No ", id, " mark"))
  end
end
local function make_finder(marks)
  return finders.new_table({results = marks, entry_maker = fenpoon["entry-maker"]})
end
local function telescope_delete_mark(prompt_bufnr)
  local confirmation = nvim.fn.input("Delete? [y/n]: ")
  local _let_5_ = actions_state.get_selected_entry()
  local index = _let_5_["index"]
  if (string.len(confirmation) == 0) then
    return print("Didn't delete mark")
  else
    fenpoon.remove(MARKS, index)
    cache.write(MARKS)
    local current_picker = actions_state.get_current_picker(prompt_bufnr)
    return current_picker:refresh(make_finder(MARKS), {reset_prompt = true})
  end
end
local function list(opts)
  local function _7_(_, map)
    map("i", "<c-d>", telescope_delete_mark)
    map("n", "<c-d>", telescope_delete_mark)
    return true
  end
  return pickers.new(themes.get_dropdown(), {prompt_title = "Fenpoon", finder = make_finder(MARKS), sorter = conf.values.generic_sorter(opts), attach_mappings = _7_}):find()
end
return list
