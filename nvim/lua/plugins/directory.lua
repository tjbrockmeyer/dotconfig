return {
	"prichrd/netrw.nvim",
	opts = {},
	dependencies = {
		{
			"echasnovski/mini.nvim",
			version = false,
			config = function()
				require("mini.icons").setup()
			end,
		},
	},
	config = function(_, opts)
		require("netrw").setup(opts)

		local pending = {}

		local function embellish(bufnr)
			if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].filetype ~= "netrw" then
				return
			end
			local style = vim.b[bufnr].netrw_liststyle
			if style ~= 0 and style ~= 1 and style ~= 3 then
				return
			end
			vim.api.nvim_buf_call(bufnr, function()
				vim.opt_local.signcolumn = "yes"
				require("netrw.ui").embelish(bufnr)
				require("netrw.actions").bind(bufnr)
			end)
		end

		local function schedule_embellish(bufnr)
			if pending[bufnr] then
				return
			end
			pending[bufnr] = true
			vim.schedule(function()
				pending[bufnr] = nil
				embellish(bufnr)
			end)
		end

		local function attach(bufnr)
			if vim.b[bufnr].netrw_icons_attach then
				return
			end
			vim.b[bufnr].netrw_icons_attach = true
			vim.api.nvim_buf_attach(bufnr, false, {
				on_lines = function()
					schedule_embellish(bufnr)
					return false
				end,
			})
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "netrw",
			group = vim.api.nvim_create_augroup("netrw_icons", { clear = true }),
			callback = function()
				local bufnr = vim.api.nvim_get_current_buf()
				attach(bufnr)
				schedule_embellish(bufnr)
			end,
		})

		vim.api.nvim_create_autocmd("FocusGained", {
			group = vim.api.nvim_create_augroup("netrw_icons", { clear = false }),
			callback = function()
				vim.schedule(function()
					for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
						if vim.bo[bufnr].filetype == "netrw" and vim.api.nvim_buf_is_loaded(bufnr) then
							schedule_embellish(bufnr)
						end
					end
				end)
			end,
		})
	end,
}
