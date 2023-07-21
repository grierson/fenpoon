(local nfnl (require :nfnl.core))
(local api (require :fenpoon.api))
(local cache (require :fenpoon.cache))
(local telescope (require :telescope))
(local themes (require :telescope.themes))
(local actions-state (require :telescope.actions.state))
(local pickers (require :telescope.pickers))
(local finders (require :telescope.finders))
(local conf (require :telescope.config))

(fn entry-maker [{: id : file}]
  "Telescope list item options"
  {:value file :ordinal file :display (nfnl.str id " - " file) :filename file})

(fn make-finder [marks]
  (finders.new_table {:results marks :entry_maker entry-maker}))

(fn telescope-delete-mark [prompt-bufnr]
  "Delete mark prompt"
  (let [confirmation (vim.fn.input "Delete? [y/n]: ")
        file (actions-state.get_selected_entry)]
    (if (= (string.len confirmation) 0)
        (print "Didn't delete mark")
        (let [marks (api.unmark file)
              current-picker (actions-state.get_current_picker prompt-bufnr)]
          (current-picker:refresh (make-finder marks) {:reset_prompt true})))))

(fn list [opts]
  "Open telescope to list marks"
  (: (pickers.new (themes.get_dropdown)
                  {:prompt_title :Fenpoon
                   :finder (make-finder (cache.read-marks))
                   :sorter (conf.values.generic_sorter opts)
                   :attach_mappings (fn [_ map]
                                      (map :i :<c-d> telescope-delete-mark)
                                      (map :n :<c-d> telescope-delete-mark)
                                      true)}) :find))

; (make-finder (cache.read))
; (list {})

(telescope.register_extension {:exports {:fenpoon list}})
