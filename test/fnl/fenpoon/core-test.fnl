(module fenpoon.core-test {require {fenpoon fenpoon.core
                                    nvim aniseed.nvim
                                    a aniseed.core}})

(deftest add-test
  (let [state []
        file :file/path/foo.fnl
        expected [file]]
    (fenpoon.add state file)
    (t.pr= expected state "Added files")
    (fenpoon.add state file)
    (t.pr= expected state "Files isnt added again")))

(deftest list-test
  (let [state []
        file :file/path/foo.fnl
        expected (.. "1 - " file)]
    (fenpoon.add state file)
    (t.pr= expected (fenpoon.list state) "Added files")))
