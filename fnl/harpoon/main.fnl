(module harpoon.main)

(var marks [])

(fn debug [] (print (vim.inspect marks)))
(fn reset [] (set marks nil))

; (var marks [{:root/relative/path/main.fnl [row col]}
;             {:root/relative/path/other [row col]}])

; (var marks [:my-project/path
;             [{:filename :root/relative/path/main.fnl :row 10 :col 8}
;              {:filename :root/relative/path/other :row 20 :col 12}]])

(defn project-root [] (vim.loop.cwd))
(defn file-path [] (vim.api.nvim_buf_get_name 0))
(defn cursor-location [] (vim.api.nvim_win_get_cursor 0))

(defn mark-file
  [state]
  (let [file (file-path)
        cursor (cursor-location)]
    (tset state file cursor)
    state))

; (mark-file {})
; (mark-file marks)
; (debug marks)
