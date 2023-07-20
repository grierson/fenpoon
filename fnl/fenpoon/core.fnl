(local nfnl (require :nfnl.core))
(local str (require :nfnl.string))

;; Generic

(fn contains [coll target]
  "Is target in coll"
  (nfnl.some (fn [v] (if (= v target) v)) coll))

;; Domain

(fn project-path [] (vim.loop.cwd))

(fn add [marks file]
  "Adds new file to marks"
  (if (contains marks file)
      marks
      (do
        (table.insert marks file)
        marks)))

(fn remove [marks target]
  (nfnl.filter (fn [v] (when (not= v target) v)) marks))

;; Telescope

(fn relative-path [proj file]
  "Remove project from file path"
  (nfnl.second (str.split file proj)))

(fn entry-maker [file]
  "Telescope list item options"
  {:value file
   :ordinal file
   :display (relative-path (project-path) file)
   :filename file})

{: contains : add : remove}
