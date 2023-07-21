(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(local core (require :fenpoon.core))
(local nfnl (require :nfnl.core))

(describe "add test"
          (fn []
            (let [proj :proj/foo/]
              (it "add first mark"
                  (fn []
                    (let [state {}
                          file :bar.fnl
                          file-path (.. proj file)
                          expected {proj [{:id 1 : file}]}
                          new-state (core.add state file-path proj)]
                      (assert.are.same expected new-state))))
              (it "idempotent - same file not added twice"
                  (fn []
                    (let [file :bar.fnl
                          state {proj [{:id 1 : file}]}
                          file-path (.. proj file)
                          new-state (core.add state file-path proj)]
                      (assert.are.same state new-state))))
              (it "add second mark"
                  (fn []
                    (let [file :second.fnl
                          file-path (.. proj file)
                          state {proj [{:id 1 :file :bar.fnl}]}
                          expected {proj [{:id 1 :file :bar.fnl}
                                          {:id 2 : file}]}
                          new-state (core.add state file-path proj)]
                      (assert.are.same expected new-state))))
              (it "earliest id is used"
                  (fn []
                    (let [file-path :proj/foo/bar.fnl
                          state {proj [{:id 2 :file :baz.fnl}]}
                          expected {proj [{:id 2 :file :baz.fnl}
                                          {:id 1 :file :bar.fnl}]}
                          new-state (core.add state file-path proj)]
                      (assert.are.same expected new-state)))))))

(describe "remove-mark test"
          (fn []
            (let [proj :proj/foo/]
              (it "remove only file but keep project"
                  (fn []
                    (let [id 1
                          state {proj [{: id :file :bar.fnl}]}
                          expected {proj []}
                          actual (core.remove state id proj)]
                      (assert.are.same expected actual))))
              (it "remove second file in project"
                  (fn []
                    (let [id 1
                          keep-file {:id 2 :file :bar.fnl}
                          state {proj [{: id :file :foo.fnl} keep-file]}
                          expected {proj [keep-file]}
                          actual (core.remove state id proj)]
                      (assert.are.same expected actual)))))))
