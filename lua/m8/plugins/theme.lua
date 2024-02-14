  return {
    "sainnhe/gruvbox-material",
    name = "gruvbox",
    priority = 100,
    config = function()
      vim.cmd([[set background=dark]])
      vim.cmd([[let g:gruvbox_material_background = 'hard']])
      vim.cmd([[let g:gruvbox_material_foreground = 'mix']])
      vim.cmd([[let g:gruvbox_material_statusline_style = 'mix']])
      vim.cmd([[colorscheme gruvbox-material]])
    end
}
