(module fenpoon.main {require {nvim aniseed.nvim
                               a aniseed.core
                               core fenpoon.core}})

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
  (print (core.list marks)))

(defn select
  [index]
  "Use index to switch to buffer"
  (let [name (core.get marks index)
        bufid (path->bufid name)]
    (swap bufid)))

; -- Log mark
; (mark)
; (log)
; (select 2)
; :lua require"fenpoon.main".mark()
; :lua require"fenpoon.main".log()
; :lua R"fenpoon.main"
