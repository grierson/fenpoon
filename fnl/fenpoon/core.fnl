(module fenpoon.core {require {a aniseed.core str aniseed.string}})

;; Generic functions

(defn contains
  [coll target]
  "Is target in coll"
  (a.some (fn [v] (if (= v target) v)) coll))

(defn find-mark-by-id
  [coll target-id]
  (each [i v (ipairs coll)]
    (let [{: id} v]
      (when (= id target-id)
        (lua "return v")))))

(defn find-mark-index-by-id
  [coll target-id]
  (each [i {: id} (ipairs coll)]
    (when (= id target-id)
      (lua "return i"))))

;; Domain

(defn next-id
  [current-ids ?target]
  "Get next available id"
  (let [target (or ?target 1)]
    (if (contains current-ids target)
        (next-id current-ids (a.inc target))
        target)))

(defn add
  [marks file]
  "!!!Mutates!!! Adds new file to marks"
  (if (contains (a.map (fn [{: file}] file) marks) file)
      marks
      (let [id (next-id (a.map (fn [{: id}] id) marks))]
        (table.insert marks {: id : file}))))

(defn remove
  [marks id]
  "!!!Mutates!!! Remove mark by id from marks"
  (let [mark-index (find-mark-index-by-id marks id)]
    (table.remove marks mark-index)))

(defn list
  [marks]
  "Pretty print index with path"
  (str.join "\n" (icollect [i file (pairs marks)]
                   (a.str i " - " file))))

(defn relative-path
  [proj file]
  "Remove project from file path"
  (string.gsub file proj ""))
