(module fenpoon.core-test {require {fenpoon fenpoon.core
                                    nvim aniseed.nvim
                                    a aniseed.core}})

(deftest add-same-file-only-added-once-test
  (let [state {}
        file :proj/foo/foo.fnl
        expected {1 file}]
    (fenpoon.add state file)
    (fenpoon.add state file)
    (t.pr= expected state "Files added twice")))

(deftest add-second-mark-test
  (let [state {}
        file1 :proj/foo/foo.fnl
        file2 :proj/foo/bar.fnl
        expected {1 file1 2 file2}]
    (fenpoon.add state file1)
    (fenpoon.add state file2)
    (t.pr= expected state "Files added in order")))

(deftest add-mark-into-earlist-index-test
  (let [file2 :proj/foo/bar.fnl
        state {2 file2}
        file1 :proj/foo/foo.fnl
        expected {1 file1 2 file2}]
    (fenpoon.add state file1)
    (t.pr= expected state "Files added in order")))

(deftest remove-mark-test
  (let [file :proj/foo/bar.fnl
        state {1 file}
        expected {}]
    (fenpoon.remove state 1)
    (t.pr= expected state "File removed")))

(deftest remove-middle-mark-test
  (let [file1 :proj/foo/foo.fnl
        file2 :proj/foo/bar.fnl
        file3 :proj/foo/baz.fnl
        state {1 file1 2 file2 3 file3}
        expected {1 file1 3 file3}]
    (fenpoon.remove state 2)
    (t.pr= expected state "File removed")))
