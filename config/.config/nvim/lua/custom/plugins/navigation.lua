return {
	-- Open buffers in the last place they were opened
	{
		"farmergreg/vim-lastplace",
	},
	{
		-- Highlight unique characters in current line for f/F to jump to
		"unblevable/quick-scope",
	},
	-- Improved vim-sneak for better movement
	{
		"ggandor/leap.nvim",
		config = function()
			-- default mappings override those set by "surround"
			-- 	require("leap").create_default_mappings()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
			vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
		end,
	},
}
