(module fenpoon.main {require {nvim aniseed.nvim
                               a aniseed.core
                               core fenpoon.core}})

; (var marks [{:filename :/relative/path/main.fnl [(row) (col)]
;             {:filename :/relative/path/other [(row) (col)]}])

(var marks [])

(defn get-path
  []
  "Get file path relative to project"
  (vim.api.nvim_buf_get_name 0))

(defn cursor-location
  []
  "(row, col) tuple"
  (vim.api.nvim_win_get_cursor 0))

(defn mark
  []
  (core.add marks (get-path) (cursor-location)))

(defn path->bufid
  [path]
  "Create/Find buffer with name. path -> bufid"
  (vim.fn.bufadd path))

(defn swap
  [bufid]
  "Swap to buffer. bufid -> void (swaps to buffer)"
  (vim.api.nvim_set_current_buf bufid))

; (mark)
; (core.list marks)
; (path->bufid (get-path))
; (swap 23)

; Notes
; ---
; select mark -> swap
