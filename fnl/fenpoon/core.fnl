(module fenpoon.core {require {a aniseed.core str aniseed.string}})

(defn- contains
  [marks target]
  "Is file path in marks?"
  (a.some (fn [path]
            (if (= path target)
                path)) marks))

(defn add
  [marks path]
  "Add new file paths to marks"
  (when (a.nil? (contains marks path))
    (table.insert marks path)))

(defn list
  [marks]
  "Pretty print index with path"
  (icollect [i file (pairs marks)]
    (a.str i " - " file)))

(defn get
  [marks index]
  "Get path from marks by index"
  (a.get marks index))
