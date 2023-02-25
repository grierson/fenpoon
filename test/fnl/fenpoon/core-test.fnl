(module fenpoon.core-test {require {fenpoon fenpoon.core nvim aniseed.nvim}})

(deftest add-test
  (let [state []
        file :file/path/foo.fnl
        cursor [1 2]
        expected [[file cursor]]]
    (fenpoon.add state file cursor)
    (t.pr= expected state "Added files")
    (fenpoon.add state file cursor)
    (t.pr= expected state "Files isnt added again")))

(deftest list-test
  (let [state []
        file :file/path/foo.fnl
        row 1
        col 2
        cursor [row col]
        expected (.. "1 - " file ":" row ":" col)]
    (fenpoon.add state file cursor)
    (t.pr= expected (fenpoon.list state) "Added files")))
