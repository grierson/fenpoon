-- [nfnl] Compiled from fnl/spec/nfnl/fenpoon/core_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local fenpoon = require("fenpoon.core")
local function _2_()
  local function _3_()
    local state = {}
    local file = "proj/foo/bar.fnl"
    local expected = {{id = 1, file = file}}
    fenpoon.add(state, file)
    fenpoon.add(state, file)
    return assert.are.same(expected, state, "Files isn't twice")
  end
  return it("same file isn't added twice", _3_)
end
return describe("add-idempotent-test", _2_)
