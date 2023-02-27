(module fenpoon.core {require {a aniseed.core str aniseed.string}})

(defn- contains
  [coll target]
  "Is target in coll"
  (a.some (fn [v] (if (= v target) v)) coll))

(defn next-id
  [current-ids target]
  "Get net available index"
  (let [target (or target 1)]
    (if (contains current-ids target)
        (next-id current-ids (a.inc target))
        target)))

(defn add
  [marks file]
  "Add new file to marks"
  (if (contains (a.vals marks) file)
      marks
      (a.assoc marks (next-id (a.keys marks)) file)))

(defn remove
  [marks id]
  (a.assoc marks id nil))

(defn list
  [marks]
  "Pretty print index with path"
  (str.join "\n" (icollect [i file (pairs marks)]
                   (a.str i " - " file))))

(defn relative-path
  [proj file]
  "Remove project from file path"
  (string.gsub file proj ""))
