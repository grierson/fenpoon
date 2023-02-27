(module fenpoon.main {require {nvim aniseed.nvim
                               a aniseed.core
                               core fenpoon.core
                               str aniseed.string
                               themes telescope.themes
                               actions telescope.actions
                               actions-state telescope.actions.state
                               pickers telescope.pickers
                               finders telescope.finders}})

(var marks {})

;; Helpers

(defn init [] true)
(defn project-path [] (vim.loop.cwd))
(defn file-path [] (vim.api.nvim_buf_get_name 0))
(defn- path->bufid
  [path]
  "Create/Find buffer with name. path -> bufid"
  (vim.fn.bufadd path))

(defn- entry-maker-fn
  [[i file]]
  {:value file
   :ordinal i
   :display (a.str i " - " (core.relative-path (project-path) file))
   :filename file})

(defn- make-finder
  []
  (finders.new_table {:results (core.table->tuples marks)
                      :entry_maker entry-maker-fn}))

(defn debug
  []
  "Debugging - print marked files"
  (if (a.empty? marks)
      (print "No marks")
      (print (core.list marks))))

;; Api

(defn mark
  []
  "Add file to marks"
  (core.add marks (file-path)))

(defn delete
  [index]
  "Add file to marks"
  (core.remove marks index))

(defn select
  [index]
  "Use index to switch to buffer"
  (if (core.contains (a.keys marks) index)
      (let [name (a.get marks index)
            bufid (path->bufid name)]
        (vim.api.nvim_set_current_buf bufid))
      (print (a.str "No " index " mark"))))

;; Telescope

(defn telescope-delete-mark
  [prompt-bufnr]
  (let [confirmation (vim.fn.input "Delete? [y/n]: ")
        {: index} (actions-state.get_selected_entry)]
    (if (= (string.len confirmation) 0)
        (print "Didn't delete mark")
        (do
          (delete index)
          (local current-picker (actions-state.get_current_picker prompt-bufnr))
          (current-picker:refresh (make-finder) {:reset_prompt true})))))

(defn telescope
  [opts]
  "Open telescope"
  (if (a.empty? marks)
      (print "No marks")
      (: (pickers.new (themes.get_dropdown)
                      {:prompt_title :Fenpoon
                       :finder (make-finder)
                       :attach_mappings (fn [_ map]
                                          (map :i :<c-d> telescope-delete-mark)
                                          (map :n :<c-d> telescope-delete-mark)
                                          true)}) :find)))
