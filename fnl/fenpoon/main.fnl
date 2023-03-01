(module fenpoon.main {require {nvim aniseed.nvim
                               a aniseed.core
                               core fenpoon.core
                               str aniseed.string
                               themes telescope.themes
                               actions telescope.actions
                               actions-state telescope.actions.state
                               pickers telescope.pickers
                               finders telescope.finders}})

(defonce cache (a.str (nvim.fn.stdpath :data) :/fenpoon.json))

(defn read-cache
  []
  (nvim.fn.json_decode (a.slurp cache)))

(defn write-cache
  [marks]
  (a.spit cache (nvim.fn.json_encode marks)))

(var marks [])

;; Helpers

(defn init [] (set marks (read-cache)))
(defn project-path [] (vim.loop.cwd))
(defn file-path [] (nvim.buf_get_name 0))

(defn- entry-maker-fn
  [{: id : file}]
  {:value file
   :ordinal id
   :display (a.str id " - " (core.relative-path (project-path) file))
   :filename file})

(defn- make-finder
  []
  (finders.new_table {:results marks :entry_maker entry-maker-fn}))

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
  (do
    (core.add marks (file-path))
    (write-cache marks)))

(defn select
  [id]
  "Use id to switch to buffer"
  (if (core.contains (a.map (fn [{: id}] id) marks) id)
      (let [file (a.get (core.find-mark-by-id marks id) :file)
            bufid (nvim.fn.bufadd file)]
        (nvim.set_current_buf bufid))
      (print (a.str "No " id " mark"))))

;; Telescope

(defn telescope-delete-mark
  [prompt-bufnr]
  (let [confirmation (nvim.fn.input "Delete? [y/n]: ")
        {: index} (actions-state.get_selected_entry)]
    (if (= (string.len confirmation) 0)
        (print "Didn't delete mark")
        (do
          (core.remove marks index)
          (write-cache marks)
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
