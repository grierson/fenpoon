-- [nfnl] Compiled from fnl/fenpoon/api.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local fenpoon = require("fenpoon.core")
local cache = require("fenpoon.cache")
local themes = require("telescope.themes")
local actions_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config")
local function file_path()
  return vim.api.nvim_buf_get_name(0)
end
local function debug()
  local marks = cache.read()
  if nfnl["empty?"](marks) then
    return print("No marks")
  else
    return print(nfnl.str(marks))
  end
end
local function mark()
  local file = file_path()
  if not nfnl["empty?"](file) then
    local result = fenpoon.add(cache.read(), file)
    return cache.write(result)
  else
    return nil
  end
end
local function unmark(file)
  local new_state = fenpoon.remove(cache.read(), file)
  return cache.write(new_state)
end
local function select(file)
  if fenpoon.contains(cache.read(), file) then
    local bufid = vim.api.bufadd(file)
    return vim.api.set_current_buf(bufid)
  else
    return print(nfnl.str("No ", file, " mark"))
  end
end
local function make_finder(marks)
  return finders.new_table({results = marks, entry_maker = fenpoon["entry-maker"]})
end
local function telescope_delete_mark(prompt_bufnr)
  local confirmation = vim.fn.input("Delete? [y/n]: ")
  local file = actions_state.get_selected_entry()
  if (string.len(confirmation) == 0) then
    return print("Didn't delete mark")
  else
    local _ = print(nfnl.str(file))
    local marks = unmark(file)
    local current_picker = actions_state.get_current_picker(prompt_bufnr)
    return current_picker:refresh(make_finder(marks), {reset_prompt = true})
  end
end
local function list(opts)
  local function _5_(_, map)
    map("i", "<c-d>", telescope_delete_mark)
    map("n", "<c-d>", telescope_delete_mark)
    return true
  end
  return pickers.new(themes.get_dropdown(), {prompt_title = "Fenpoon", finder = make_finder(cache.read()), sorter = conf.values.generic_sorter(opts), attach_mappings = _5_}):find()
end
return {["file-path"] = file_path, debug = debug, mark = mark, unmark = unmark, ["make-finder"] = make_finder, ["telescope-delete-mark"] = telescope_delete_mark, list = list}
