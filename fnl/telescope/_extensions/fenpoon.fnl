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
  {:value id :ordinal file :display (nfnl.str id " - " file) :filename file})

(fn make-finder [marks]
  (finders.new_table {:results marks :entry_maker entry-maker}))

(fn telescope-delete-mark [prompt-bufnr]
  "Delete mark prompt"
  (let [confirmation (vim.fn.input "Delete? [y/n]: ")]
    (if (= confirmation :y)
        (let [{: value} (actions-state.get_selected_entry)
              marks (api.unmark value)
              current-picker (actions-state.get_current_picker prompt-bufnr)]
          (current-picker:refresh (make-finder marks) {:reset_prompt true}))
        (print "Didn't delete mark"))))

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

(telescope.register_extension {:exports {:fenpoon list}})
