(module fenpoon.main {require {nvim aniseed.nvim
                               a aniseed.core
                               core fenpoon.core
                               str aniseed.string
                               themes telescope.themes
                               actions telescope.actions
                               actions-state telescope.actions.state
                               pickers telescope.pickers
                               finders telescope.finders}})

; marks
; {1 :file/full/path
;  2 :other/full/path}
(var marks {})

;; Helpers

(defn init [] (print "hello fenpoon"))
(defn project-path [] (vim.loop.cwd))
(defn file-path [] (vim.api.nvim_buf_get_name 0))
(defn- path->bufid
  [path]
  "Create/Find buffer with name. path -> bufid"
  (vim.fn.bufadd path))

(defn debug
  []
  "Debugging - print marked files"
  (if (a.empty? marks)
      (print "No marks")
      (print (core.list marks))))

(defn entry-maker-fn
  [[i file]]
  {:value file
   :ordinal i
   :display (a.str i " - " (core.relative-path (project-path) file))
   :filename file})

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

(defn telescope
  [opts]
  "Open telescope"
  (if (a.empty? marks)
      (print "No marks")
      (: (pickers.new (themes.get_dropdown)
                      {:finder (finders.new_table {:results (core.table->tuples marks)
                                                   :entry_maker entry-maker-fn})
                       :prompt_title :Fenpoon}) :find)))
