(local nfnl (require :nfnl.core))
(local Path (require :plenary.path))

(fn contains [coll target]
  "Is target in coll"
  (nfnl.some (fn [v] (if (= v target) v)) coll))

(fn project-path [] (vim.loop.cwd))

(fn normalize-path [item ?proj]
  "Get filename from full file path

  :proj/path/file.fnl :proj/path => file.fnl"
  (: (Path:new item) :make_relative (or ?proj (project-path))))

(fn current-file-path [] (vim.api.nvim_buf_get_name 0))

{: contains : project-path : normalize-path : current-file-path}
