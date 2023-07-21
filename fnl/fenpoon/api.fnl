(local nfnl (require :nfnl.core))
(local core (require :fenpoon.core))
(local utils (require :fenpoon.utils))
(local cache (require :fenpoon.cache))

(fn mark []
  "Add file to marks"
  (let [file (utils.current-file-path)]
    (when (not (nfnl.empty? file))
      (let [state (core.add (cache.read-state) file)]
        (cache.write state)))))

(fn unmark [file]
  (let [state (core.remove (cache.read-state) file)]
    (cache.write state)))

(fn select [id]
  "Use id to switch to buffer"
  (let [marks (cache.read-marks)
        {: file} (core.get-mark-by-id marks id)]
    (if (nfnl.nil? file)
        (print (nfnl.str "No mark"))
        (let [filepath (.. (utils.project-path) "/" file)
              bufid (vim.fn.bufadd filepath)]
          (vim.api.nvim_set_current_buf bufid)))))

{: mark : unmark : select}
