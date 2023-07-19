-- [nfnl] Compiled from fnl/spec/nfnl/fenpoon/core_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local core = require("fenpoon.core")
core["find-mark-by-id"]({{id = 1}, {id = 2}}, 1)
local function _2_()
  local function _3_()
    assert.are.same(core.contains({1, 2, 3}, 1), 1)
    return assert.are.same(core.contains({1, 2, 3}, 2), 2)
  end
  it("list contains value", _3_)
  local function _4_()
    assert.is_nil(core.contains({1, 2, 3}, 0))
    return assert.is_nil(core.contains({1, 2, 3}, 4), 2)
  end
  return it("list doesn't contains value", _4_)
end
return describe("contains test", _2_)
