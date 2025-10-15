return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      prismals = {}, -- enable Prisma LSP
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.prisma",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end,
}
