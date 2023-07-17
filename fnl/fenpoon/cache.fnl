(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local nvim (autoload :nfnl.nvim))

(var cache (core.str (nvim.fn.stdpath :data) :/fenpoon.json))

(fn read []
  (let [marks (core.slurp cache)]
    (if (core.empty? marks)
        []
        (nvim.fn.json_decode marks))))

(fn write [marks]
  (core.spit cache (nvim.fn.json_encode marks)))
