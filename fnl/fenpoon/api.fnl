(local nfnl (require :nfnl.core))
(local core (require :fenpoon.core))
(local cache (require :fenpoon.cache))
(local utils (require :fenpoon.utils))

(fn debug []
  "Debugging - print marked files"
  (let [state (cache.read-state)]
    (if (nfnl.empty? state)
        (print "No marks")
        (print (nfnl.str state)))))

(fn mark []
  "Add file to marks"
  (let [file (utils.current-file-path)]
    (when (not (nfnl.empty? file))
      (let [state (core.add (cache.read-state) file)]
        (cache.write state)))))

(fn unmark [file]
  (let [state (core.remove (cache.read-state) file)]
    (cache.write state)))

(fn select [file]
  "Use file to switch to buffer"
  (if (core.contains (cache.read-marks) file)
      (let [bufid (vim.api.bufadd file)]
        (vim.api.set_current_buf bufid))
      (print (nfnl.str "No " file " mark"))))

{: debug : mark : unmark : select}
