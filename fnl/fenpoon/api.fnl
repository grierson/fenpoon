(local nfnl (require :nfnl.core))
(local fenpoon (require :fenpoon.core))
(local cache (require :fenpoon.cache))
(local themes (require :telescope.themes))
(local actions-state (require :telescope.actions.state))
(local pickers (require :telescope.pickers))
(local finders (require :telescope.finders))
(local conf (require :telescope.config))

;; Helpers

(fn file-path [] (vim.api.nvim_buf_get_name 0))

;; Api

(fn debug []
  "Debugging - print marked files"
  (let [marks (cache.read)]
    (if (nfnl.empty? marks)
        (print "No marks")
        (print (nfnl.str marks)))))

(fn mark []
  "Add file to marks"
  (let [file (file-path)]
    (when (not (nfnl.empty? file))
      (let [result (fenpoon.add (cache.read) file)]
        (cache.write result)))))

(fn unmark [file]
  (let [new-state (fenpoon.remove (cache.read) file)]
    (cache.write new-state)))

(fn select [file]
  "Use file to switch to buffer"
  (if (fenpoon.contains (cache.read) file)
      (let [bufid (vim.api.bufadd file)]
        (vim.api.set_current_buf bufid))
      (print (nfnl.str "No " file " mark"))))

;; Telescope

(fn make-finder [marks]
  (finders.new_table {:results marks :entry_maker fenpoon.entry-maker}))

(fn telescope-delete-mark [prompt-bufnr]
  "Delete mark prompt"
  (let [confirmation (vim.fn.input "Delete? [y/n]: ")
        file (actions-state.get_selected_entry)]
    (if (= (string.len confirmation) 0)
        (print "Didn't delete mark")
        (let [_ (print (nfnl.str file))
              marks (unmark file)
              current-picker (actions-state.get_current_picker prompt-bufnr)]
          (current-picker:refresh (make-finder marks) {:reset_prompt true})))))

(fn list [opts]
  "Open telescope to list marks"
  (: (pickers.new (themes.get_dropdown)
                  {:prompt_title :Fenpoon
                   :finder (make-finder (cache.read))
                   :sorter (conf.values.generic_sorter opts)
                   :attach_mappings (fn [_ map]
                                      (map :i :<c-d> telescope-delete-mark)
                                      (map :n :<c-d> telescope-delete-mark)
                                      true)}) :find))

{: file-path
 : debug
 : mark
 : unmark
 : make-finder
 : telescope-delete-mark
 : list}
