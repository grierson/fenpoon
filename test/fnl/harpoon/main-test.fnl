(module harpoon.main-test
  {require {harpoon harpoon.main}})


(deftest something-simple
  (t.= 1 1 "1 should equal 1, I hope!"))

(deftest mark-file-test
  (t.= {} (harpoon.mark-file {}) "file is added"))
