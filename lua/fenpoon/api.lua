-- [nfnl] Compiled from fnl/fenpoon/api.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local core = require("fenpoon.core")
local utils = require("fenpoon.utils")
local cache = require("fenpoon.cache")
local function mark()
  local file = utils["current-file-path"]()
  if not nfnl["empty?"](file) then
    local state = core.add(cache["read-state"](), file)
    return cache.write(state)
  else
    return nil
  end
end
local function unmark(file)
  local state = core.remove(cache["read-state"](), file)
  return cache.write(state)
end
local function select(id)
  local marks = cache["read-marks"]()
  local _let_2_ = core["get-mark-by-id"](marks, id)
  local file = _let_2_["file"]
  if nfnl["nil?"](file) then
    return print(nfnl.str("No mark"))
  else
    local filepath = (utils["project-path"]() .. "/" .. file)
    local bufid = vim.fn.bufadd(filepath)
    return vim.api.nvim_set_current_buf(bufid)
  end
end
return {mark = mark, unmark = unmark, select = select}
