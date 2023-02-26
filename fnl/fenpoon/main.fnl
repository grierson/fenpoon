(module fenpoon.main {require {nvim aniseed.nvim
                               a aniseed.core
                               core fenpoon.core
                               str aniseed.string
                               themes telescope.themes
                               actions telescope.actions
                               actions-state telescope.actions.state
                               pickers telescope.pickers
                               finders telescope.finders
                               builtin telescope.builtin
                               conf telescope.config}})

; State
(var marks [])

(defn init
  []
  "Init function"
  (print "hello fenpoon"))

(defn relative-path [path]
  (string.gsub path (vim.loop.cwd) ""))

(defn get-path
  []
  "Get file path relative to project"
  (vim.api.nvim_buf_get_name 0))

(defn mark
  []
  "Add file to marks"
  (core.add marks (get-path)))

(defn path->bufid
  [path]
  "Create/Find buffer with name. path -> bufid"
  (vim.fn.bufadd path))

(defn swap
  [bufid]
  "Swap to buffer. bufid -> void (swaps to buffer)"
  (vim.api.nvim_set_current_buf bufid))

(defn log
  []
  "Debugging - print marked files"
  (if (a.empty? marks)
      (print "No marks")
      (print (core.list marks))))

(defn select
  [index]
  "Use index to switch to buffer"
  (let [name (core.get marks index)
        bufid (path->bufid name)]
    (swap bufid)))

(defn list->table
  [list]
  "[:foo :bar] -> [[1 :foo] [2 :bar]]"
  (a.map-indexed (fn [v] v) list))

(defn entry-maker-fn
  [[i entry]]
  "Make telescope list item"
  {:value entry
   :ordinal entry
   :display (a.str i " - " (relative-path entry))
   :filename entry})

(defn telescope
  [opts]
  "Open telescope"
  (if (a.empty? marks)
      (print "No marks")
      (: (pickers.new (themes.get_dropdown)
                      {:sorter (conf.generic_sorter opts)
                       :finder (finders.new_table {:results (list->table marks)
                                                   :entry_maker entry-maker-fn})
                       :prompt_title :Fenpoon}) :find)))
