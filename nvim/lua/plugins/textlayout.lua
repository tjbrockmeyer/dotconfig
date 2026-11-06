return {
	{
		-- dir = vim.fn.expand("~/code/textlayout"),
		"tjbrockmeyer/textlayout.nvim",
		lazy = false,
		keys = {
			{ "<leader>tl", "<cmd>TextLayout toggle<cr>", desc = "Toggle text layout preview" },
			{ "<leader>tf", "<cmd>TextLayout focus<cr>", desc = "Jump into the text layout preview" },
			{ "<leader>tb", "<cmd>TextLayout unfocus<cr>", desc = "Jump back out of the text layout preview" },
			{ "<leader>tL", "<cmd>TextLayout export<cr>", desc = "Export text layout at natural width" },
			{ "<leader>tR", "<cmd>TextLayout swap<cr>", desc = "Swap preview / text in place (.tlmd)" },
		},
		opts = {},
		config = function(_, opts)
			require("textlayout").setup(opts)
		end,
	},
}
