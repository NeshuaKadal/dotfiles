return {
    {
	-- Highlight color codes with it's color #000000
	'brenoprata10/nvim-highlight-colors', config = function() require('nvim-highlight-colors').setup() end
    },
    {
	-- Make nvim transparent (MANDATORY)
	"xiyaowong/transparent.nvim", lazy = false
    },
    {
	-- Better navigation than default or mini.jump
	"smoka7/hop.nvim", version = "*", config = function() require("hop").setup() end,
    },
    {
	-- Keybind Help
	"folke/which-key.nvim", event = "VeryLazy", config = function() require("which-key").setup() end,
	keys = {{ "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)" },},
    }
}
