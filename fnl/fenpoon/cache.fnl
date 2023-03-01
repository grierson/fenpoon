(module fenpoon.cache {require {nvim aniseed.nvim a aniseed.core}})

(defonce cache (a.str (nvim.fn.stdpath :data) :/fenpoon.json))

(defn read
  []
  (let [marks (a.slurp cache)]
    (if (a.empty? marks)
        []
        (nvim.fn.json_decode marks))))

(defn write
  [marks]
  (a.spit cache (nvim.fn.json_encode marks)))
