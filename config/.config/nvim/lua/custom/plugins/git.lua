return {
	{
		-- "voldikss/vim-floaterm",
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			-- https://github.com/akinsho/toggleterm.nvim/wiki/Tips-and-Tricks#using-toggleterm-with-powershell
			local powershell_options = {
				shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell",
				shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
				shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
				shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
				shellquote = "",
				shellxquote = "",
			}
			for option, value in pairs(powershell_options) do
				vim.opt[option] = value
			end

			require("toggleterm").setup({
				open_mapping = [[<c-\>]],
				terminal_mappings = true,
				-- direction = "float",
			})

			-- TODO: didn't seem to work the best
			--
			-- local Terminal = require("toggleterm.terminal").Terminal
			-- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
			-- function _lazygit_toggle()
			-- 	lazygit:toggle()
			-- end
			--
			-- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				-- vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end
			-- if you only want these mappings for toggle term use term://*toggleterm#* instead
			-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
			vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

			-- vim.keymap.set("n", "<leader>\\", ":Toggleterm dir=float<CR>", { desc = "Float terminal" })
		end,
	},
	-- {
	-- 	"voldikss/vim-floaterm",
	-- },
}
