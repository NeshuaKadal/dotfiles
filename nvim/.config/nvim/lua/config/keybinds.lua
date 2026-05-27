-- Leader Keybind
vim.g.mapleader = " "

-- Mini Keybinds
vim.keymap.set("n", "<leader>e",  function() require('mini.files').open() end,                { desc = "Browse: Files" })
vim.keymap.set('n', '<leader>ff', function() require('mini.pick').builtin.files() end,        { desc = "Pick: Files" })
vim.keymap.set('n', '<leader>fb', function() require('mini.pick').builtin.buffers() end,      { desc = "Pick: Buffers" })
vim.keymap.set('n', '<leader>fg', function() require('mini.pick').builtin.grep() end,         { desc = "Pick: Grep" })
vim.keymap.set('n', '<leader>tw', function() require('mini.trailspace').trim()end,            { desc = 'Trim trailing whitespace' })
vim.keymap.set('n', '<leader>tl', function() require('mini.trailspace').trim_last_lines()end, { desc = 'Trim trailing lines' })

-- Hop Keybinds
vim.keymap.set("n", "<leader>hw", function() require("hop").hint_words() end, { desc = "Hop Words" })
vim.keymap.set("n", "<leader>hl", function() require("hop").hint_lines() end, { desc = "Hop Lines" })
vim.keymap.set("n", "<leader>hc", function() require("hop").hint_char1() end, { desc = "Hop Char" })
vim.keymap.set("n", "<leader>h2", function() require("hop").hint_char2() end, { desc = "Hop 2 Char" })

