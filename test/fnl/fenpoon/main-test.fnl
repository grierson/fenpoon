(module fenpoon.main-test
        {require {fenpoon fenpoon.main nvim aniseed.nvim nvim aniseed.nvim}})

(deftest something-simple
  (t.= 1 1 "1 should equal 1, I hope!"))

(def path (.. (fenpoon.project-root) "/lua/fenpoon"))
(def root (.. :runtimepath^= path))
(nvim.ex.set root)
(nvim.ex.source (.. path :/main.lua))
(nvim.ex.lua "require('fenpoon').mark()")

(deftest mark-file-test
  (nvim.ex.edit :a.txt)
  (fenpoon.mark)
  (nvim.ex.edit :b.txt)
  (fenpoon.mark)
  (t.= 2 (fenpoon.debug) "two files marked"))
