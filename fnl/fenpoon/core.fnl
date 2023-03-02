(module fenpoon.core {require {a aniseed.core str aniseed.string}})

;; Generic

(defn contains
  [coll target]
  "Is target in coll"
  (a.some (fn [v] (if (= v target) v)) coll))

;; Domain

(defn- project-path [] (vim.loop.cwd))

(defn get-ids
  [marks]
  (a.map (fn [{: id}] id) marks))

(defn get-files
  [marks]
  (a.map (fn [{: file}] file) marks))

(defn find-mark-by-id
  [marks target-id]
  (each [i v (ipairs marks)]
    (let [{: id} v]
      (when (= id target-id)
        (lua "return v")))))

(defn- find-mark-index-by-id
  [marks target-id]
  "Find mark by id"
  (each [i {: id} (ipairs marks)]
    (when (= id target-id)
      (lua "return i"))))

(defn- next-id
  [current-ids ?target]
  "Get next available id"
  (let [target (or ?target 1)]
    (if (contains current-ids target)
        (next-id current-ids (a.inc target))
        target)))

(defn print
  [marks]
  "Pretty print index with path"
  (str.join "\n" (icollect [i file (pairs marks)]
                   (a.str i " - " file))))

;; Impure functions

(defn add
  [marks file]
  "!!!Mutates!!! Adds new file to marks"
  (if (contains (get-files marks) file)
      marks
      (let [id (next-id (get-ids marks))]
        (table.insert marks {: id : file}))))

(defn remove
  [marks id]
  "!!!Mutates!!! Remove mark by id from marks"
  (let [mark-index (find-mark-index-by-id marks id)]
    (table.remove marks mark-index)))

;; Telescope

(defn- relative-path
  [proj file]
  "Remove project from file path"
  (let [x (string.gsub file proj "")]
    x))

(defn entry-maker
  [{: id : file}]
  "Telescope list item options"
  {:value file
   :ordinal file
   :display (a.str id " - " (relative-path (project-path) file))
   :filename file})
