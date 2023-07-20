-- [nfnl] Compiled from fnl/fenpoon/cache.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local cache = (vim.fn.stdpath("data") .. "/fenpoon.json")
local function read()
  local marks = nfnl.slurp(cache)
  if nfnl["empty?"](marks) then
    return {}
  else
    return vim.fn.json_decode(marks)
  end
end
local function write(marks)
  nfnl.spit(cache, vim.fn.json_encode(marks))
  return read()
end
return {read = read, write = write, cache = cache}
