-- [nfnl] Compiled from fnl/telescope/_extensions/fenpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local api = require("fenpoon.api")
local utils = require("fenpoon.utils")
local telescope = require("telescope")
local themes = require("telescope.themes")
local actions_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config")
local function entry_maker(file, _3fproj_path)
  return {value = file, ordinal = file, display = utils["normalize-path"](file, _3fproj_path), filename = file}
end
local function make_finder(marks)
  return finders.new_table({results = marks, entry_maker = entry_maker})
end
local function telescope_delete_mark(prompt_bufnr)
  local confirmation = vim.fn.input("Delete? [y/n]: ")
  local file = actions_state.get_selected_entry()
  if (string.len(confirmation) == 0) then
    return print("Didn't delete mark")
  else
    local marks = api.unmark(file)
    local current_picker = actions_state.get_current_picker(prompt_bufnr)
    return current_picker:refresh(make_finder(marks), {reset_prompt = true})
  end
end
local function list(opts)
  local function _2_(_, map)
    map("i", "<c-d>", telescope_delete_mark)
    map("n", "<c-d>", telescope_delete_mark)
    return true
  end
  return pickers.new(themes.get_dropdown(), {prompt_title = "Fenpoon", finder = make_finder(cache.read()), sorter = conf.values.generic_sorter(opts), attach_mappings = _2_}):find()
end
return telescope.register_extension({exports = {fenpoon = list}})
