return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup()

		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", function()
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			local compilers = {
				{ name = "go_build", label = "go build" },
				{ name = "go_test", label = "go test" },
				{ name = "eslint", label = "eslint" },
				{ name = "tsc", label = "tsc" },
				{ name = "jest", label = "jest" },
				{ name = "node_test", label = "node --test" },
			}

			pickers
				.new({}, {
					prompt_title = "Run compiler",
					finder = finders.new_table({
						results = compilers,
						entry_maker = function(entry)
							return {
								value = entry.name,
								display = entry.label,
								ordinal = entry.label,
							}
						end,
					}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr)
						actions.select_default:replace(function()
							local selection = action_state.get_selected_entry()
							actions.close(prompt_bufnr)
							if not selection then
								return
							end
							vim.cmd("compiler " .. selection.value)
							vim.cmd("make!")
							vim.cmd("cwindow")
						end)
						return true
					end,
				})
				:find()
		end, { desc = "Fuzzy pick and run a compiler" })
	end,
}
