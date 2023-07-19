(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(local core (require :fenpoon.core))

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

(describe "get-ids test"
          (fn []
            (it "list contains value"
                (fn []
                  (assert.are.same (core.get-ids [{:id 1} {:id 2}]) [1 2])))))

(describe "get-files test"
          (fn []
            (it "list contains value"
                (fn []
                  (let [file1 :a
                        file2 :b]
                    (assert.are.same (core.get-files [{:file file1}
                                                      {:file file2}])
                                     [file1 file2]))))))

(describe "find-mark-by-id test"
          (fn []
            (it "list contains value"
                (fn []
                  (let [target 2
                        file1 {:id 1 :file :a}
                        file2 {:id 2 :file :b}]
                    (assert.are.same (core.find-mark-by-id [file1 file2] target)
                                     file2))))))

(describe "find-mark-by-index test"
          (fn []
            (it "list contains value"
                (fn []
                  (assert.are.same (core.find-mark-index-by-id [{:id 1
                                                                 :file :a}
                                                                {:id 3
                                                                 :file :b}]
                                                               3)
                                   2)))))

(describe "next-id test"
          (fn []
            (it "default to 1"
                (fn []
                  (assert.are.same (core.next-id []) 1)))
            (it "get next id after 1"
                (fn []
                  (assert.are.same (core.next-id [1]) 2)))
            (it "get earliest id"
                (fn []
                  (assert.are.same (core.next-id [2]) 1)))))

(describe "add test"
          (fn []
            (it "file added"
                (fn []
                  (let [state []
                        file :proj/foo/bar.fnl
                        expected [{:id 1 : file}]]
                    (core.add state file)
                    (assert.are.same expected state))))
            (it "same file isn't added twice"
                (fn []
                  (let [state []
                        file :proj/foo/bar.fnl
                        expected [{:id 1 : file}]]
                    (core.add state file)
                    (core.add state file)
                    (assert.are.same expected state))))
            (it "second file added"
                (fn []
                  (let [state []
                        file1 :proj/foo/foo.fnl
                        file2 :proj/foo/bar.fnl
                        expected [{:id 1 :file file1} {:id 2 :file file2}]]
                    (core.add state file1)
                    (core.add state file2)
                    (assert.are.same expected state))))
            (it "add mark into earlist index test"
                (fn []
                  (let [file2 :bar.fnl
                        state [{:id 2 :file file2}]
                        file1 :foo.fnl
                        expected [{:id 2 :file file2} {:id 1 :file file1}]]
                    (core.add state file1)
                    (assert.are.same expected state))))))

(describe "remove-mark test"
          (fn []
            (it "remove file"
                (fn []
                  (let [id 1
                        file :proj/foo/bar.fnl
                        state [{: id : file}]
                        expected []]
                    (core.remove state id)
                    (assert.are.same expected state "File removed"))))
            (it "remove file in the middle"
                (fn []
                  (let [file1 {:id 1 :file :proj/foo/foo.fnl}
                        file2 {:id 2 :file :proj/foo/bar.fnl}
                        file3 {:id 3 :file :proj/foo/baz.fnl}
                        state [file1 file2 file3]
                        expected [file1 file3]]
                    (core.remove state 2)
                    (assert.are.same expected state "File removed"))))))
