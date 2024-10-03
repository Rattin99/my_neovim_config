return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<leader>tt]],
        direction = "horizontal", -- This opens the terminal at the bottom, similar to VSCode
      })
    end,
  },
}
