(local {: autoload} (require :nfnl.module))
(local reload (autoload :plenary.reload))
(local notify (autoload :nfnl.notify))

(vim.api.nvim_set_keymap :n :<localleader>pt :<Plug>PlenaryTestFile
                         {:desc "Run the current test file with plenary."})

(vim.api.nvim_set_keymap :n :<localleader>tf
                         "<cmd>PlenaryBustedDirectory lua/spec/<cr>"
                         {:desc "Run all tests with plenary."})

{}
