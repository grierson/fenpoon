(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(var cache (.. (vim.fn.stdpath :data) :/fenpoon.json))

(fn read []
  (let [marks (core.slurp cache)]
    (if (core.empty? marks)
        []
        (vim.fn.json_decode marks))))

(fn write [marks]
  (core.spit cache (vim.fn.json_encode marks)))
