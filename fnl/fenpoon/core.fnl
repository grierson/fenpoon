(local nfnl (require :nfnl.core))
(local str (require :nfnl.string))

; {
;   "/Users/<user>/project/thing": [
;                                   {"id": 1
;                                   "file": "submodule/file.fnl"}
;                                   ]
;
; }

;; Generic

(fn contains [coll target]
  "Is target in coll"
  (nfnl.some (fn [v] (if (= v target) v)) coll))

(fn get-files [marks]
  "[{:files 1} {:files 2}] => [1 2]"
  (nfnl.map (fn [{: file}] file) marks))

(fn relative-path [proj file]
  "Remove project from file path"
  (nfnl.second (str.split proj file)))

(relative-path :proj/foo :proj/foo/bar.fnl)

;; Domain

(if (= nil nil) 1 2)

(fn project-path [] (vim.loop.cwd))

(fn add [state file-path ?proj-path]
  "Adds new file to marks"
  (let [proj (or ?proj-path (project-path))
        file (relative-path proj file-path)
        marks (?. state proj)]
    (if (= marks nil)
        (do
          (tset state proj [{:id 1 : file}])
          state)
        (let [files (get-files marks)]
          (if (contains files file)
              state
              (do
                (table.insert marks {:id 1 : file})
                state))))))

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
