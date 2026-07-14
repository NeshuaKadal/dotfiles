return {
    {
	'MeanderingProgrammer/render-markdown.nvim',
	dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
	config = function()
	    require('render-markdown').setup({
	    heading = {
		icons = { '' },
		signs = { 'H1', 'H2', 'H3', 'H4', 'H5', 'H6' },
		border = true,
	    },
	    latex = { enabled = true }
	}) end,
    },
}
