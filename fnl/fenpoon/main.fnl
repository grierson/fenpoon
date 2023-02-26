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
  "Print marked files"
  (if (a.empty? marks)
      (print "No marks")
      (print (str.join "\n" (core.list marks)))))

(defn select
  [index]
  "Use index to switch to buffer"
  (let [name (core.get marks index)
        bufid (path->bufid name)]
    (swap bufid)))

; -- Log mark
; (mark)
; (log)
; :lua require"fenpoon.main".mark()
; :lua require"fenpoon.main".log()
; :lua R"fenpoon.main"

(defn telescope
  [opts]
  (if (a.empty? marks)
      (print "No marks")
      (: (pickers.new (themes.get_dropdown)
                      {:finder (finders.new_table {:results (core.list marks)})
                       :prompt_title :Fenpoon}) :find)))

; (mark)
; (telescope)
