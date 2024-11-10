-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		-- Creates a beautiful debugger UI
		"rcarriga/nvim-dap-ui",

		-- Required dependency for nvim-dap-ui
		"nvim-neotest/nvim-nio",

		-- Installs the debug adapters for you
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Add your own debuggers here
		"mfussenegger/nvim-dap-python",

		-- Virtual inline text for value of locales
		"theHamsta/nvim-dap-virtual-text",
	},
	keys = function(_, keys)
		local dap = require("dap")
		local dapui = require("dapui")
		return {
			-- Basic debugging keymaps, feel free to change to your liking!
			{ "<F5>", dap.continue, desc = "Debug: Start/Continue" },
			{ "<F11>", dap.step_into, desc = "Debug: Step Into" },
			{ "<F10>", dap.step_over, desc = "Debug: Step Over" },
			{ "<s+F11>", dap.step_out, desc = "Debug: Step Out" },
			{ "<leader>b", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
			{
				"<leader>B",
				function()
					dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
				end,
				desc = "Debug: Set Breakpoint",
			},
			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			{ "<F7>", dapui.toggle, desc = "Debug: See last session result." },
			unpack(keys),
		}
	end,
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("mason-nvim-dap").setup({
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
				"python", -- TODO: not sure I need this
				"debugpy",
			},
		})

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		dapui.setup({
			-- Set icons to characters that are more likely to work in every terminal.
			--    Feel free to remove or use ones that you like more! :)
			--    Don't feel like these are good choices.
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			controls = {
				icons = {
					pause = "⏸",
					play = "▶",
					step_into = "⏎",
					step_over = "⏭",
					step_out = "⏮",
					step_back = "b",
					run_last = "▶▶",
					terminate = "⏹",
					disconnect = "⏏",
				},
			},
		})

		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		-- setup virtual text
		require("nvim-dap-virtual-text").setup({})

		-- Python specific setup
		-- requires debugpy to be globally pip installed. not sure how to make it use .venv..
		local dap_python = require("dap-python")
		local path = require("mason-registry").get_package("debugpy"):get_install_path()

		-- TODO: should be able to use linux-cultist/venv-selector to automatically set python venv in project and find python from there
		-- This is using the venv that mason installed debugpy is in...not venv in project..
		if vim.fn.has("win32") == 1 then
			dap_python.setup(path .. "/venv/Scripts/python.exe")
		else
			dap_python.setup(path .. "/venv/bin/python")
		end

		-- NOTE: Wasn't really working...also shouldn't be setting keybindings specific to python for all filetypes
		-- -- Then this can be the simple one again? (After you 'uv install --dev debugpy' in the python project)
		-- -- dap_python.setup("python")
		-- dap_python.test_runner = "pytest"
		-- dap_python.detached = vim.fn.has("win32") == 0
		-- vim.keymap.set("n", "<leader>dn", dap_python.test_method, { desc = "Python test method" })
		-- vim.keymap.set("n", "<leader>df", dap_python.test_class, { desc = "Python test class" })
		-- -- vim.keymap.set("n", "<leader>dS", require("dap-python").debug_selection, { desc = "Python debug selection" })

		-- Godot specific setup
		dap.configurations.gdscript = {
			{
				type = "godot",
				request = "launch",
				name = "Launch scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			},
		}
	end,
}
