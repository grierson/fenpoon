-- [nfnl] Compiled from fnl/fenpoon/api.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local core = require("fenpoon.core")
local cache = require("fenpoon.cache")
local utils = require("fenpoon.utils")
local function debug()
  local marks = cache.read()
  if nfnl["empty?"](marks) then
    return print("No marks")
  else
    return print(nfnl.str(marks))
  end
end
local function mark()
  local file = utils["current-file-path"]()
  if not nfnl["empty?"](file) then
    local result = core.add(cache.read(), file)
    return cache.write(result)
  else
    return nil
  end
end
local function unmark(file)
  local new_state = core.remove(cache.read(), file)
  return cache.write(new_state)
end
local function select(file)
  if core.contains(cache.read(), file) then
    local bufid = vim.api.bufadd(file)
    return vim.api.set_current_buf(bufid)
  else
    return print(nfnl.str("No ", file, " mark"))
  end
end
return {debug = debug, mark = mark, unmark = unmark}
