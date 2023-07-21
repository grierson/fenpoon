(local nfnl (require :nfnl.core))
(local utils (require :fenpoon.utils))

; {
;   "/Users/<user>/project/thing": [{
;                                       "id": 1
;                                       "file": "submodule/file.fnl"
;                                   }]
;
; }

(fn get-files [marks]
  "[{:files 1} {:files 2}] => [1 2]"
  (nfnl.map (fn [{: file}] file) marks))

(fn get-ids [marks]
  (nfnl.map (fn [{: id}] id) marks))

(fn next-id [current-ids ?target]
  "Get next available id"
  (let [target (or ?target 1)]
    (if (utils.contains current-ids target)
        (next-id current-ids (nfnl.inc target))
        target)))

(fn add [state file-path ?proj-path]
  "Adds new file to marks"
  (let [proj (or ?proj-path (utils.project-path))
        file (utils.normalize-path file-path proj)
        marks (?. state proj)]
    (if (= marks nil)
        (do
          (tset state proj [{:id 1 : file}])
          state)
        (let [files (get-files marks)]
          (if (utils.contains files file)
              state
              (let [ids (get-ids marks)
                    id (next-id ids)]
                (do
                  (table.insert marks {: id : file})
                  state)))))))

(fn remove-mark [target-id marks]
  (nfnl.filter (fn [{: id}] (not= id target-id)) marks))

(fn remove [state target-id ?proj-path]
  (let [proj (or ?proj-path (utils.project-path))]
    (nfnl.update state proj (partial remove-mark target-id))))

{: add : remove}
