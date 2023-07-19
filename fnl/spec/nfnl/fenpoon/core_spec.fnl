(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(local core (require :fenpoon.core))

(core.find-mark-by-id [{:id 1} {:id 2}] 1)

(describe "contains test"
          (fn []
            (it "list contains value"
                (fn []
                  (assert.are.same (core.contains [1 2 3] 1) 1)
                  (assert.are.same (core.contains [1 2 3] 2) 2)))
            (it "list doesn't contains value"
                (fn []
                  (assert.is_nil (core.contains [1 2 3] 0))
                  (assert.is_nil (core.contains [1 2 3] 4) 2)))))

; (describe :add-idempotent-test
;           (fn []
;             (it "same file isn't added twice"
;                 (fn []
;                   (let [state []
;                         file :proj/foo/bar.fnl
;                         expected [{:id 1 : file}]]
;                     (fenpoon.add state file)
;                     (fenpoon.add state file)
;                     (assert.are.same expected state "Files isn't twice"))))))

; (describe :add-second-mark-test
;           (let [state []
;                 file1 :proj/foo/foo.fnl
;                 file2 :proj/foo/bar.fnl
;                 expected [{:id 1 :file file1} {:id 2 :file file2}]]
;             (fenpoon.add state file1)
;             (fenpoon.add state file2)
;             (assert.are.same expected state "Files added in order")))
;
; (describe :add-mark-into-earlist-index-test
;           (let [file2 :bar.fnl
;                 state [{:id 2 :file file2}]
;                 file1 :foo.fnl
;                 expected [{:id 2 :file file2} {:id 1 :file file1}]]
;             (fenpoon.add state file1)
;             (assert.are.same expected state "Files added in order")))
;
; (describe :remove-mark-test
;           (let [id 1
;                 file :proj/foo/bar.fnl
;                 state [{: id : file}]
;                 expected []]
;             (fenpoon.remove state id)
;             (assert.are.same expected state "File removed")))
;
; (describe :remove-middle-mark-test
;           (let [file1 {:id 1 :file :proj/foo/foo.fnl}
;                 file2 {:id 2 :file :proj/foo/bar.fnl}
;                 file3 {:id 3 :file :proj/foo/baz.fnl}
;                 state [file1 file2 file3]
;                 expected [file1 file3]]
;             (fenpoon.remove state 2)
;             (assert.are.same expected state "File removed")))
