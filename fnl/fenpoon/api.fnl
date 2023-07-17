(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))
(local nvim (autoload :nfnl.nvim))
(local fenpoon (autoload :fenpoon.core))
(local cache (autoload :fenpoon.cache))
(local themes (autoload :telescope.themes))
(local actions-state (autoload :telescope.actions.state))
(local pickers (autoload :telescope.pickers))
(local finders (autoload :telescope.finders))
(local conf (autoload :telescope.config))

(var MARKS [])

;; Helpers

(fn setup [] (set MARKS (cache.read)))
(fn file-path [] (nvim.buf_get_name 0))

;; Api

(fn debug []
  "Debugging - print marked files"
  (if (core.empty? MARKS)
      (print "No marks")
      (print (fenpoon.print MARKS))))

(fn mark []
  "Add file to marks"
  (let [file (file-path)]
    (when (not (core.empty? file))
      (do
        (fenpoon.add MARKS file)
        (cache.write MARKS)))))

(fn select [id]
  "Use id to switch to buffer"
  (if (fenpoon.contains (fenpoon.get-ids MARKS) id)
      (let [file (core.get (fenpoon.find-mark-by-id MARKS id) :file)
            bufid (nvim.fn.bufadd file)]
        (nvim.set_current_buf bufid))
      (print (core.str "No " id " mark"))))

;; Telescope

(fn make-finder [marks]
  (finders.new_table {:results marks :entry_maker fenpoon.entry-maker}))

(fn telescope-delete-mark [prompt-bufnr]
  "Delete mark prompt"
  (let [confirmation (nvim.fn.input "Delete? [y/n]: ")
        {: index} (actions-state.get_selected_entry)]
    (if (= (string.len confirmation) 0)
        (print "Didn't delete mark")
        (do
          (fenpoon.remove MARKS index)
          (cache.write MARKS)
          (let [current-picker (actions-state.get_current_picker prompt-bufnr)]
            (current-picker:refresh (make-finder MARKS) {:reset_prompt true}))))))

(fn list [opts]
  "Open telescope to list marks"
  (: (pickers.new (themes.get_dropdown)
                  {:prompt_title :Fenpoon
                   :finder (make-finder MARKS)
                   :sorter (conf.values.generic_sorter opts)
                   :attach_mappings (fn [_ map]
                                      (map :i :<c-d> telescope-delete-mark)
                                      (map :n :<c-d> telescope-delete-mark)
                                      true)}) :find))
