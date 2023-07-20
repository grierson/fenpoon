-- [nfnl] Compiled from fnl/spec/nfnl/fenpoon/core_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local core = require("fenpoon.core")
local nfnl = require("nfnl.core")
local function _2_()
  local function _3_()
    assert.are.same(core.contains({1, 2, 3}, 1), 1)
    assert.are.same(core.contains({1, 2, 3}, 2), 2)
    return assert.are.same(core.contains({"a", "b", "c"}, "a"), "a")
  end
  it("list contains value", _3_)
  local function _4_()
    assert.is_nil(core.contains({1, 2, 3}, 0))
    return assert.is_nil(core.contains({1, 2, 3}, 4), 2)
  end
  return it("list doesn't contains value", _4_)
end
describe("contains test", _2_)
local function _5_()
  local function _6_()
    local state = {}
    local file = "proj/foo/bar.fnl"
    local expected = {file}
    core.add(state, file)
    return assert.are.same(expected, state)
  end
  it("file added", _6_)
  local function _7_()
    local state = {}
    local file = "proj/foo/bar.fnl"
    local expected = {file}
    core.add(state, file)
    core.add(state, file)
    return assert.are.same(expected, state)
  end
  it("same file isn't added twice", _7_)
  local function _8_()
    local state = {}
    local file1 = "proj/foo/foo.fnl"
    local file2 = "proj/foo/bar.fnl"
    local expected = {file1, file2}
    core.add(state, file1)
    core.add(state, file2)
    return assert.are.same(expected, state)
  end
  it("second file added", _8_)
  local function _9_()
    local file2 = "bar.fnl"
    local state = {file2}
    local file1 = "foo.fnl"
    local expected = {file2, file1}
    local actual = core.add(state, file1)
    return assert.are.same(expected, actual)
  end
  return it("add mark into earlist index", _9_)
end
describe("add test", _5_)
local function _10_()
  local function _11_()
    local file = "proj/foo/bar.fnl"
    local state = {file}
    local expected = {}
    local actual = core.remove(state, file)
    return assert.are.same(expected, actual)
  end
  it("remove file", _11_)
  local function _12_()
    local file1 = "proj/foo/foo.fnl"
    local file2 = "proj/foo/bar.fnl"
    local file3 = "proj/foo/baz.fnl"
    local state = {file1, file2, file3}
    local expected = {file1, file3}
    local actual = core.remove(state, file2)
    return assert.are.same(expected, actual)
  end
  return it("remove file in the middle", _12_)
end
return describe("remove-mark test", _10_)
