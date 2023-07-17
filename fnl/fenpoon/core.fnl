(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local str (autoload :nfnl.string))

;; Generic

(fn contains [coll target]
  "Is target in coll"
  (core.some (fn [v] (if (= v target) v)) coll))

;; Domain

(fn project-path [] (vim.loop.cwd))

(fn get-ids [marks]
  (core.map (fn [{: id}] id) marks))

(fn get-files [marks]
  (core.map (fn [{: file}] file) marks))

(fn find-mark-by-id [marks target-id]
  (each [i v (ipairs marks)]
    (let [{: id} v]
      (when (= id target-id)
        (lua "return v")))))

(fn find-mark-index-by-id [marks target-id]
  "Find mark by id"
  (each [i {: id} (ipairs marks)]
    (when (= id target-id)
      (lua "return i"))))

(fn next-id [current-ids ?target]
  "Get next available id"
  (let [target (or ?target 1)]
    (if (contains current-ids target)
        (next-id current-ids (core.inc target))
        target)))

(fn print [marks]
  "Pretty print index with path"
  (str.join "\n" (icollect [i file (pairs marks)]
                   (core.str i " - " file))))

;; Impure functions

(fn add [marks file]
  "!!!Mutates!!! Adds new file to marks"
  (if (contains (get-files marks) file)
      marks
      (let [id (next-id (get-ids marks))]
        (table.insert marks {: id : file}))))

(fn remove [marks id]
  "!!!Mutates!!! Remove mark by id from marks"
  (let [mark-index (find-mark-index-by-id marks id)]
    (table.remove marks mark-index)))

;; Telescope

(fn relative-path [proj file]
  "Remove project from file path"
  (let [x (string.gsub file proj "")]
    x))

(fn entry-maker [{: id : file}]
  "Telescope list item options"
  {:value file
   :ordinal file
   :display (core.str id " - " (relative-path (project-path) file))
   :filename file})
