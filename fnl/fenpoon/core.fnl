(module fenpoon.core {require {a aniseed.core str aniseed.string}})

(defn- contains
  [marks target]
  "Is file path in marks?"
  (a.some (fn [[path _]]
            (if (= path target)
                path)) marks))

(defn add
  [state path cursor]
  "Add new file paths to marks"
  (when (a.nil? (contains state path))
    (table.insert state [path cursor])))

(defn list
  [state]
  "Pretty print index with path"
  (str.join "\n" (icollect [i [file [row col]] (ipairs state)]
                   (a.str i " - " file ":" row ":" col))))
