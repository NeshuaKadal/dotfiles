return {
    {
	'brenoprata10/nvim-highlight-colors',
	config = function()
	    require('nvim-highlight-colors').setup({})
	end
    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
	    require('lualine').setup({options = {theme = 'everforest',component_separators = '|',section_separators = ''}})
	end
    },
    {
	"xiyaowong/transparent.nvim",
	lazy = false
    },
}
