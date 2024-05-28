return {
  'echasnovski/mini.pairs',
    config = function()
        require("mini.pairs").setup({
            mappings = {
                ["'"] = false,
                ['"'] = false,
                ['`'] = false,
            }
        })
    end
}
