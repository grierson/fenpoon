local _2afile_2a = "fnl/fenpoon/cache.fnl"
local _2amodule_name_2a = "fenpoon.cache"
local _2amodule_2a
do
  package.loaded[_2amodule_name_2a] = {}
  _2amodule_2a = package.loaded[_2amodule_name_2a]
end
local _2amodule_locals_2a
do
  _2amodule_2a["aniseed/locals"] = {}
  _2amodule_locals_2a = (_2amodule_2a)["aniseed/locals"]
end
local a, nvim = require("fenpoon.aniseed.core"), require("fenpoon.aniseed.nvim")
do end (_2amodule_locals_2a)["a"] = a
_2amodule_locals_2a["nvim"] = nvim
local cache = ((_2amodule_2a).cache or a.str(nvim.fn.stdpath("data"), "/fenpoon.json"))
do end (_2amodule_2a)["cache"] = cache
local function read()
  local marks = a.slurp(cache)
  if a["empty?"](marks) then
    return {}
  else
    return nvim.fn.json_decode(marks)
  end
end
_2amodule_2a["read"] = read
local function write(marks)
  return a.spit(cache, nvim.fn.json_encode(marks))
end
_2amodule_2a["write"] = write
return _2amodule_2a