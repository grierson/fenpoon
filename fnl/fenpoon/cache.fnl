(local nfnl (require :nfnl.core))
(local utils (require :fenpoon.utils))

(local cache (.. (vim.fn.stdpath :data) :/fenpoon.json))

(fn read-state []
  (let [json (nfnl.slurp cache)]
    (if (nfnl.empty? json)
        {}
        (let [state (vim.fn.json_decode json)]
          (if (nfnl.empty? json)
              {}
              state)))))

(fn read-marks [?proj-path]
  (let [state (read-state)]
    (let [project (or ?proj-path (utils.project-path))
          marks (?. state project)]
      (if (= nil marks)
          []
          marks))))

(fn write [state]
  (do
    (nfnl.spit cache (vim.fn.json_encode state))
    (read-marks)))

{: read-state : read-marks : write}
