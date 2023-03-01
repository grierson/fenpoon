(module fenpoon.main {require {nvim aniseed.nvim
                               a aniseed.core
                               core fenpoon.core
                               cache fenpoon.cache
                               str aniseed.string
                               themes telescope.themes
                               actions telescope.actions
                               actions-state telescope.actions.state
                               pickers telescope.pickers
                               finders telescope.finders}})

(var marks [])

;; Helpers

(defn init [] (set marks (cache.read)))
(defn- project-path [] (vim.loop.cwd))
(defn- file-path [] (nvim.buf_get_name 0))

;; Api

(defn debug
  []
  "Debugging - print marked files"
  (if (a.empty? marks)
      (print "No marks")
      (print (core.print marks))))

(defn mark
  []
  "Add file to marks"
  (do
    (core.add marks (file-path))
    (cache.write marks)))

(defn select
  [id]
  "Use id to switch to buffer"
  (if (core.contains (core.get-ids) id)
      (let [file (a.get (core.find-mark-by-id marks id) :file)
            bufid (nvim.fn.bufadd file)]
        (nvim.set_current_buf bufid))
      (print (a.str "No " id " mark"))))

;; Telescope

(defn- entry-maker-fn
  [{: id : file}]
  "Telescope list item options"
  {:value file
   :ordinal id
   :display (a.str id " - " (core.relative-path (project-path) file))
   :filename file})

(defn- make-finder
  [marks]
  (finders.new_table {:results marks :entry_maker entry-maker-fn}))

(defn- telescope-delete-mark
  [prompt-bufnr]
  "Delete mark prompt"
  (let [confirmation (nvim.fn.input "Delete? [y/n]: ")
        {: index} (actions-state.get_selected_entry)]
    (if (= (string.len confirmation) 0)
        (print "Didn't delete mark")
        (do
          (core.remove marks index)
          (cache.write marks)
          (local current-picker (actions-state.get_current_picker prompt-bufnr))
          (current-picker:refresh (make-finder marks) {:reset_prompt true})))))

(defn telescope
  [opts]
  "Open telescope to list marks"
  (if (a.empty? marks)
      (print "No marks")
      (: (pickers.new (themes.get_dropdown)
                      {:prompt_title :Fenpoon
                       :finder (make-finder marks)
                       :attach_mappings (fn [_ map]
                                          (map :i :<c-d> telescope-delete-mark)
                                          (map :n :<c-d> telescope-delete-mark)
                                          true)}) :find)))
