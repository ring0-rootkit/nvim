return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			variant = "auto", -- auto, main, moon, or dawn
			dark_variant = "main", -- main, moon, or dawn

			styles = {
				-- transparency = true,
			},
			enable = {
				legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
			},
		})

		vim.cmd("colorscheme rose-pine")
	end,
}
