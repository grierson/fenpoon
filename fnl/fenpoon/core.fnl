(module fenpoon.core {require {a aniseed.core str aniseed.string}})

(defn- contains
  [marks target]
  "Is file path in marks?"
  (a.some (fn [[path _]]
            (if (= path target)
                path)) marks))

(defn add
  [marks path cursor]
  "Add new file paths to marks"
  (when (a.nil? (contains marks path))
    (table.insert marks [path cursor])))

(defn list
  [marks]
  "Pretty print index with path"
  (str.join "\n" (icollect [i [file [row col]] (ipairs marks)]
                   (a.str i " - " file ":" row ":" col))))

(defn get
  [marks index]
  (a.get marks index))
