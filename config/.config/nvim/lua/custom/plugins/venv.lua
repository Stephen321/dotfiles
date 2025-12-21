return {
	-- NOTE: This is python specific...should be only enabled if in python pyproject. Other python config is in base init.lua
	"linux-cultist/venv-selector.nvim",
	ft = "python",
	branch = "main",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-telescope/telescope.nvim",
		"mfussenegger/nvim-dap",
		"mfussenegger/nvim-dap-python",
	},
	config = function()
		require("venv-selector").setup({
			auto_refresh = true,
			dap_enabled = true,
			parents = 3,
		})
	end,
	lazy = true,
	-- event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	keys = {
		{ ",v", "<cmd>VenvSelect<cr>" },
		-- -- Keymap to open VenvSelector to pick a venv.
		-- { '<leader>vs', '<cmd>VenvSelect<cr>' },
		-- -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
		-- { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
	},
}
