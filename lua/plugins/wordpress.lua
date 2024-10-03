return {
  -- Add the WordPress plugin for Neovim
  {
    "bitpoke/wordpress.nvim",
    config = function()
      local wp = require("wordpress")
      local lspconfig = require("lspconfig")
      local null_ls = require("null-ls")

      -- Setup Intelephense for PHP, WordPress and WooCommerce development
      lspconfig.intelephense.setup(wp.intelephense)

      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.phpcs.with(wp.null_ls_phpcs),
          null_ls.builtins.formatting.phpcbf.with(wp.null_ls_phpcs),
        },
      })
    end,
  },
  -- Additional dependencies, if needed
  {
    "jay-babu/mason-null-ls.nvim", -- Make sure you have this for null-ls integration
    config = function()
      require("mason-null-ls").setup({
        automatic_installation = {
          exclude = { "phpcs", "phpcbf" },
        },
      })
    end,
  },
}
