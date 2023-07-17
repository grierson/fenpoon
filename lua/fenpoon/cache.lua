-- [nfnl] Compiled from fnl/fenpoon/cache.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local nvim = autoload("nfnl.nvim")
local cache = core.str(nvim.fn.stdpath("data"), "/fenpoon.json")
local function read()
  local marks = core.slurp(cache)
  if core["empty?"](marks) then
    return {}
  else
    return nvim.fn.json_decode(marks)
  end
end
local function write(marks)
  return core.spit(cache, nvim.fn.json_encode(marks))
end
return write
