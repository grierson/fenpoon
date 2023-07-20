(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(local core (require :fenpoon.core))
(local nfnl (require :nfnl.core))

(describe "contains test"
          (fn []
            (it "list contains value"
                (fn []
                  (assert.are.same (core.contains [1 2 3] 1) 1)
                  (assert.are.same (core.contains [1 2 3] 2) 2)
                  (assert.are.same (core.contains [:a :b :c] :a) :a)))
            (it "list doesn't contains value"
                (fn []
                  (assert.is_nil (core.contains [1 2 3] 0))
                  (assert.is_nil (core.contains [1 2 3] 4) 2)))))

(describe "add test"
          (fn []
            (it "file added"
                (fn []
                  (let [state []
                        file :proj/foo/bar.fnl
                        expected [file]]
                    (core.add state file)
                    (assert.are.same expected state))))
            (it "same file isn't added twice"
                (fn []
                  (let [state []
                        file :proj/foo/bar.fnl
                        expected [file]]
                    (core.add state file)
                    (core.add state file)
                    (assert.are.same expected state))))
            (it "second file added"
                (fn []
                  (let [state []
                        file1 :proj/foo/foo.fnl
                        file2 :proj/foo/bar.fnl
                        expected [file1 file2]]
                    (core.add state file1)
                    (core.add state file2)
                    (assert.are.same expected state))))
            (it "add mark into earlist index"
                (fn []
                  (let [file2 :bar.fnl
                        state [file2]
                        file1 :foo.fnl
                        expected [file2 file1]
                        actual (core.add state file1)]
                    (assert.are.same expected actual))))))

(describe "remove-mark test"
          (fn []
            (it "remove file"
                (fn []
                  (let [file :proj/foo/bar.fnl
                        state [file]
                        expected []
                        actual (core.remove state file)]
                    (assert.are.same expected actual))))
            (it "remove file in the middle"
                (fn []
                  (let [file1 :proj/foo/foo.fnl
                        file2 :proj/foo/bar.fnl
                        file3 :proj/foo/baz.fnl
                        state [file1 file2 file3]
                        expected [file1 file3]
                        actual (core.remove state file2)]
                    (assert.are.same expected actual))))))
