(module fenpoon.main {require {nvim aniseed.nvim a aniseed.core}})

(var marks [])

(defn debug [] (vim.inspect marks))
(defn reset [] (set marks nil))

; (var marks [{:root/relative/path/main.fnl [row col]}
;             {:root/relative/path/other [row col]}])

; (var marks [:my-project/path
;             [{:filename :root/relative/path/main.fnl :row 10 :col 8}
;              {:filename :root/relative/path/other :row 20 :col 12}]])

(defn project-root [] (vim.loop.cwd))
(defn file-path [] (vim.api.nvim_buf_get_name 0))
(defn cursor-location [] (vim.api.nvim_win_get_cursor 0))

(defn mark_file
  []
  (let [file (file-path)
        cursor (cursor-location)]
    (table.insert marks [file cursor])))

(defn list_marks
  []
  (icollect [i [file _] (ipairs marks)]
    [i file]))

(reset)
(table.insert marks [:foo [20 30]])
(table.insert marks [:bar [40 50]])
(mark_file)
(list_marks)
;
; (def foo
;   [{:file/a [10 20]} {:file/b [30 40]}])
