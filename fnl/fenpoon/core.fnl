(module fenpoon.core {require {a aniseed.core}})

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
  (icollect [i [file [row col]] (ipairs state)]
    [i (.. file ":" row ":" col)]))
