(module fenpoon.cache {require {nvim aniseed.nvim a aniseed.core}})

(defonce cache (a.str (nvim.fn.stdpath :data) :/fenpoon.json))

(defn read
  []
  (nvim.fn.json_decode (a.slurp cache)))

(defn write
  [marks]
  (a.spit cache (nvim.fn.json_encode marks)))
