(module fenpoon.main {require {nvim aniseed.nvim a aniseed.core}})

; (var marks [{:filename :/relative/path/main.fnl [(row) (col)]
;             {:filename :/relative/path/other [(row) (col)]}])

(var marks [])

(defn debug [] (vim.inspect marks))
(defn reset [] (set marks nil))
(defn project-root [] (vim.loop.cwd))

(defn file-path []
  (string.gsub (vim.api.nvim_buf_get_name 0) (vim.loop.cwd) ""))

(defn cursor-location [] (vim.api.nvim_win_get_cursor 0))

(defn- contains
  [coll value]
  "Is file path in marks?"
  (a.some (fn [[name _]]
            (if (= name value)
                name)) coll))

(defn add
  [state path cursor]
  "Add new file paths to marks"
  (when (a.nil? (contains state path))
    (table.insert state [path cursor])))

(defn list
  []
  (icollect [i [file _] (ipairs marks)]
    [i file]))

; (reset)
; (mark_file [] (file-path) (cursor-location))
; (list_marks)
;
; (def foo
;   [{:file/a [10 20]} {:file/b [30 40]}])
