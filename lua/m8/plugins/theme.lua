return {
    "rose-pine/neovim",
    name = "rose-pine",
    init = function()
        require("rose-pine").setup({
            styles = {
                transparency = true,
            },
        })
    end,
}
