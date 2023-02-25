(module fenpoon.main-test
        {require {fenpoon fenpoon.main nvim aniseed.nvim nvim aniseed.nvim}})

(deftest add-test
  (let [state []
        file :file/path/foo.fnl
        cursor [1 2]
        expected [[file cursor]]]
    (fenpoon.add state file cursor)
    (t.pr= expected state "Added files")
    (fenpoon.add state file cursor)
    (t.pr= expected state "Files isnt added twice")))

; (def path (.. (fenpoon.project-root) :/lua/fenpoon))
; (def root (.. :runtimepath^= path))
; (nvim.ex.set root)
; (nvim.ex.source (.. path :/main.lua))
; (nvim.ex.lua "require('fenpoon').mark()")
;
; (deftest mark-file-test
;   (nvim.ex.edit :a.txt)
;   (fenpoon.mark)
;   (nvim.ex.edit :b.txt)
;   (fenpoon.mark)
;   (t.= 2 (fenpoon.debug) "two files marked"))
