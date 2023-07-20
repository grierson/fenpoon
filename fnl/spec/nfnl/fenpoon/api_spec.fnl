(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(local api (require :fenpoon.api))
(local nfnl (require :nfnl.core))
(local cache (require :fenpoon.cache))

(describe "mark test"
          (fn []
            (it "marks file"
                (fn []
                  (let [_ (api.mark)]
                    (assert.are.same (cache.read) nil))))))
