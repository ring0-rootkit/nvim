return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        init = function()
            require("rose-pine").setup({
                -- variant = "dawn",
                styles = {
                    transparency = true,
                },
            })
        end,
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
