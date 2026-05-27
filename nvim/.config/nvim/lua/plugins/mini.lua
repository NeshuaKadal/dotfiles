return {
    {
	'nvim-mini/mini.nvim',
	version = false,
	config = function()
	    -- Text Editing
	    require('mini.ai').setup()
	    require('mini.align').setup()
	    require('mini.comment').setup()
	    require('mini.completion').setup()
	    require('mini.keymap').setup()
	    require('mini.move').setup()
	    require('mini.operators').setup()
	    require('mini.pairs').setup()
	    require('mini.snippets').setup()
	    require('mini.splitjoin').setup()
	    require('mini.surround').setup()
	    -- General Workflow
	    require('mini.basics').setup()
	    require('mini.bracketed').setup()
	    require('mini.bufremove').setup()
	    require('mini.cmdline').setup()
	    require('mini.files').setup()
	    require('mini.pick').setup()
	    -- Appearance
	    require('mini.animate').setup()
	    require('mini.cursorword').setup()
	    require('mini.hipatterns').setup()
	    require('mini.icons').setup()
	    require('mini.indentscope').setup()
	    require('mini.notify').setup()
	    require('mini.starter').setup()
	    require('mini.statusline').setup()
	    require('mini.tabline').setup()
	    require('mini.trailspace').setup()

	    local mk = require('mini.keymap')
	    mk.map_multistep('i', '<Tab>',   { 'pmenu_next' })
	    mk.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
	    mk.map_multistep('i', '<CR>',    { 'pmenu_accept', 'minipairs_cr' })
	    mk.map_multistep('i', '<BS>',    { 'minipairs_bs' })
	end
    },
}
