(module fenpoon.main {require {nvim aniseed.nvim
                               a aniseed.core
                               core fenpoon.core
                               cache fenpoon.cache
                               themes telescope.themes
                               actions-state telescope.actions.state
                               pickers telescope.pickers}})

(var MARKS [])

;; Helpers

(defn init [] (set MARKS (cache.read)))
(defn- file-path [] (nvim.buf_get_name 0))

;; Api

(defn debug
  []
  "Debugging - print marked files"
  (if (a.empty? MARKS)
      (print "No marks")
      (print (core.print MARKS))))

(defn mark
  []
  "Add file to marks"
  (do
    (core.add MARKS (file-path))
    (cache.write MARKS)))

(defn select
  [id]
  "Use id to switch to buffer"
  (if (core.contains (core.get-ids) id)
      (let [file (a.get (core.find-mark-by-id MARKS id) :file)
            bufid (nvim.fn.bufadd file)]
        (nvim.set_current_buf bufid))
      (print (a.str "No " id " mark"))))

;; Telescope

(defn make-finder
  [marks]
  (finders.new_table {:results marks :entry_maker core.entry-maker}))

(defn- telescope-delete-mark
  [prompt-bufnr]
  "Delete mark prompt"
  (let [confirmation (nvim.fn.input "Delete? [y/n]: ")
        {: index} (actions-state.get_selected_entry)]
    (if (= (string.len confirmation) 0)
        (print "Didn't delete mark")
        (do
          (core.remove MARKS index)
          (cache.write MARKS)
          (local current-picker (actions-state.get_current_picker prompt-bufnr))
          (current-picker:refresh (make-finder MARKS) {:reset_prompt true})))))

(defn telescope
  [opts]
  "Open telescope to list marks"
  (if (a.empty? MARKS)
      (print "No marks")
      (: (pickers.new (themes.get_dropdown)
                      {:prompt_title :Fenpoon
                       :finder (make-finder MARKS)
                       :attach_mappings (fn [_ map]
                                          (map :i :<c-d> telescope-delete-mark)
                                          (map :n :<c-d> telescope-delete-mark)
                                          true)}) :find)))
