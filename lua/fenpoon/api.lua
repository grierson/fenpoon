-- [nfnl] Compiled from fnl/fenpoon/api.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local core = require("fenpoon.core")
local cache = require("fenpoon.cache")
local utils = require("fenpoon.utils")
local function debug()
  local state = cache["read-state"]()
  if nfnl["empty?"](state) then
    return print("No marks")
  else
    return print(nfnl.str(state))
  end
end
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
local function select(file)
  if core.contains(cache["read-marks"](), file) then
    local bufid = vim.api.bufadd(file)
    return vim.api.set_current_buf(bufid)
  else
    return print(nfnl.str("No ", file, " mark"))
  end
end
return {debug = debug, mark = mark, unmark = unmark, select = select}
