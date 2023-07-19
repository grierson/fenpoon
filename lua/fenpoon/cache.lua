-- [nfnl] Compiled from fnl/fenpoon/cache.fnl by https://github.com/Olical/nfnl, do not edit.
local core = require("nfnl.core")
local cache = (vim.fn.stdpath("data") .. "/fenpoon.json")
local function read()
  local marks = core.slurp(cache)
  if core["empty?"](marks) then
    return {}
  else
    return vim.fn.json_decode(marks)
  end
end
local function write(marks)
  return core.spit(cache, vim.fn.json_encode(marks))
end
return write
