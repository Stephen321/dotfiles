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
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup({})

			-- basic telescope configuration
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			-- TODO: <leader>h overlaps with Git [H]unk commands
			-- vim.keymap.set("n", "<C-e>", function()
			-- 	toggle_telescope(harpoon:list())
			-- end, { desc = "Open harpoon window" })
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<leader>ha", function()
				harpoon:list():add()
			end, { desc = "Add to Harpoon" })
			vim.keymap.set("n", "<leader>h1", function()
				harpoon:list():select(1)
			end, { desc = "Go to Harpoon 1" })
			vim.keymap.set("n", "<leader>h2", function()
				harpoon:list():select(2)
			end, { desc = "Go to Harpoon 2" })
			vim.keymap.set("n", "<leader>h3", function()
				harpoon:list():select(3)
			end, { desc = "Go to Harpoon 3" })
			vim.keymap.set("n", "<leader>h4", function()
				harpoon:list():select(4)
			end, { desc = "Go to Harpoon 4" })

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-A-P>", function()
				harpoon:list():prev()
			end, { desc = "Harpoon previous buffer" })
			vim.keymap.set("n", "<C-A-N>", function()
				harpoon:list():next()
			end, { desc = "Harpoon next buffer" })
		end,
	},
}
