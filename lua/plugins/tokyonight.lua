-- ~/.config/nvim/lua/plugins/tokyonight.lua
return {
  {
    "folke/tokyonight.nvim",
    -- load eagerly so it applies before other plugins/themes try to override
    lazy = false,
    priority = 1000,
    config = function()
      -- ensure truecolor is turned on before loading the colorscheme
      vim.o.termguicolors = true
      -- ensure dark background (tokyonight expects dark)
      vim.o.background = "dark"
      -- set the style before the colorscheme loads
      vim.g.tokyonight_style = "moon"
      -- any other optional tweaks:
      -- vim.g.tokyonight_transparent = true
      -- load it
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
