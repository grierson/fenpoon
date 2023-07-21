-- [nfnl] Compiled from fnl/telescope/_extensions/fenpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local api = require("fenpoon.api")
local cache = require("fenpoon.cache")
local telescope = require("telescope")
local themes = require("telescope.themes")
local actions_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config")
local function entry_maker(_1_)
  local _arg_2_ = _1_
  local id = _arg_2_["id"]
  local file = _arg_2_["file"]
  return {value = id, ordinal = nfnl.str(id), display = nfnl.str(id, " - ", file), filename = file}
end
local function make_finder(marks)
  return finders.new_table({results = marks, entry_maker = entry_maker})
end
local function telescope_delete_mark(prompt_bufnr)
  local confirmation = vim.fn.input("Delete? [y/n]: ")
  if (confirmation == "y") then
    local _let_3_ = actions_state.get_selected_entry()
    local value = _let_3_["value"]
    local marks = api.unmark(value)
    local current_picker = actions_state.get_current_picker(prompt_bufnr)
    return current_picker:refresh(make_finder(marks), {reset_prompt = true})
  else
    return print("Didn't delete mark")
  end
end
local function list(opts)
  local function _5_(_, map)
    map("i", "<c-d>", telescope_delete_mark)
    map("n", "<c-d>", telescope_delete_mark)
    return true
  end
  return pickers.new(themes.get_dropdown(), {prompt_title = "Fenpoon", finder = make_finder(cache["read-marks"]()), sorter = conf.values.generic_sorter(opts), attach_mappings = _5_}):find()
end
return telescope.register_extension({exports = {fenpoon = list}})
