-- [nfnl] Compiled from fnl/spec/nfnl/fenpoon/api_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local api = require("fenpoon.api")
local nfnl = require("nfnl.core")
local cache = require("fenpoon.cache")
local function _2_()
  local function _3_()
    local _ = api.mark()
    return assert.are.same(cache.read(), nil)
  end
  return it("marks file", _3_)
end
return describe("mark test", _2_)
