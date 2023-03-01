(module fenpoon.core-test {require {fenpoon fenpoon.core
                                    nvim aniseed.nvim
                                    a aniseed.core}})

(deftest add-idempotent-test
  (let [state []
        file :proj/foo/bar.fnl
        expected [{:id 1 : file}]]
    (fenpoon.add state file)
    (fenpoon.add state file)
    (t.pr= expected state "Files isn't twice")))

(deftest add-second-mark-test
  (let [state []
        file1 :proj/foo/foo.fnl
        file2 :proj/foo/bar.fnl
        expected [{:id 1 :file file1} {:id 2 :file file2}]]
    (fenpoon.add state file1)
    (fenpoon.add state file2)
    (t.pr= expected state "Files added in order")))

(deftest add-mark-into-earlist-index-test
  (let [file2 :bar.fnl
        state [{:id 2 :file file2}]
        file1 :foo.fnl
        expected [{:id 2 :file file2} {:id 1 :file file1}]]
    (fenpoon.add state file1)
    (t.pr= expected state "Files added in order")))

(deftest remove-mark-test
  (let [id 1
        file :proj/foo/bar.fnl
        state [{: id : file}]
        expected []]
    (fenpoon.remove state id)
    (t.pr= expected state "File removed")))

(deftest remove-middle-mark-test
  (let [file1 {:id 1 :file :proj/foo/foo.fnl}
        file2 {:id 2 :file :proj/foo/bar.fnl}
        file3 {:id 3 :file :proj/foo/baz.fnl}
        state [file1 file2 file3]
        expected [file1 file3]]
    (fenpoon.remove state 2)
    (t.pr= expected state "File removed")))
