(local nfnl (require :nfnl.core))

(local cache (.. (vim.fn.stdpath :data) :/fenpoon.json))

(fn read []
  (let [marks (nfnl.slurp cache)]
    (if (nfnl.empty? marks)
        []
        (vim.fn.json_decode marks))))

(fn write [marks]
  (do
    (nfnl.spit cache (vim.fn.json_encode marks))
    (read)))

{: read : write : cache}
