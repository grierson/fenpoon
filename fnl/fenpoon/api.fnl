(local nfnl (require :nfnl.core))
(local core (require :fenpoon.core))
(local cache (require :fenpoon.cache))
(local utils (require :fenpoon.utils))

(fn debug []
  "Debugging - print marked files"
  (let [marks (cache.read)]
    (if (nfnl.empty? marks)
        (print "No marks")
        (print (nfnl.str marks)))))

(fn mark []
  "Add file to marks"
  (let [file (utils.current-file-path)]
    (when (not (nfnl.empty? file))
      (let [result (core.add (cache.read) file)]
        (cache.write result)))))

(fn unmark [file]
  (let [new-state (core.remove (cache.read) file)]
    (cache.write new-state)))

(fn select [file]
  "Use file to switch to buffer"
  (if (core.contains (cache.read) file)
      (let [bufid (vim.api.bufadd file)]
        (vim.api.set_current_buf bufid))
      (print (nfnl.str "No " file " mark"))))

{: debug : mark : unmark}
