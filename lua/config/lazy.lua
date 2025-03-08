local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  settings = {
    intelephense = {
      stubs = {
        "bcmath",
        "bz2",
        "calendar",
        "Core",
        "curl",
        "date",
        "dba",
        "dom",
        "enchant",
        "fileinfo",
        "filter",
        "ftp",
        "gd",
        "gettext",
        "hash",
        "iconv",
        "imap",
        "intl",
        "json",
        "ldap",
        "libxml",
        "mbstring",
        "mcrypt",
        "mysql",
        "mysqli",
        "password",
        "pcntl",
        "pcre",
        "PDO",
        "pdo_mysql",
        "Phar",
        "readline",
        "recode",
        "Reflection",
        "regex",
        "session",
        "SimpleXML",
        "soap",
        "sockets",
        "sodium",
        "SPL",
        "standard",
        "superglobals",
        "sysvsem",
        "sysvshm",
        "tokenizer",
        "xml",
        "xdebug",
        "xmlreader",
        "xmlwriter",
        "yaml",
        "zip",
        "zlib",
        "wordpress",
        "woocommerce",
        "acf-pro",
        "acf-stubs",
        "wordpress-globals",
        "wp-cli",
        "genesis",
        "polylang",
        "sbi",
      },
      diagnostics = { enable = true },
      files = {
        maxsize = 10000000,
      },
    },
  },
  -- Add this to your existing spec table
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "lazyvim.plugins.extras.lang.typescript" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    { import = "plugins" },
    { import = "plugins.wordpress" },
    { import = "lazyvim.plugins.extras.lsp.none-ls" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    {
      "nvimtools/none-ls.nvim", -- Replaced null-ls.nvim with none-ls.nvim
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        local none_ls = require("null-ls")
        none_ls.setup({
          sources = {
            none_ls.builtins.formatting.stylua,
            none_ls.builtins.formatting.shfmt,
          },
        })
      end,
    },
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = function()
        require("toggleterm").setup({
          direction = "horizontal", -- This makes the terminal appear at the bottom
          size = 15, -- You can adjust the size of the terminal
        })
      end,
    },
    --laravel support--
    {
      "adalessa/laravel.nvim", -- Laravel plugin for Neovim
      dependencies = {
        "nvim-telescope/telescope.nvim", -- Required for Laravel commands
        "MunifTanjim/nui.nvim", -- Required for Laravel UI components
      },
      cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Git" },
      keys = {
        { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel Artisan" },
        { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel Routes" },
        { "<leader>lm", ":Laravel related<cr>", desc = "Laravel Related Files" },
      },
      config = function()
        require("laravel").setup()
      end,
    },
    -- Blade template support
    {
      "jwalton512/vim-blade", -- Syntax highlighting for Blade templates
      ft = "blade", -- Filetype detection for Blade files
    },

    -- PHP support
    {
      "phpactor/phpactor", -- PHP language server
      ft = "php", -- Filetype detection for PHP files
      build = "composer install --no-dev --optimize-autoloader",
      config = function()
        require("lspconfig").phpactor.setup({})
      end,
    },

    -- Debugging with PHP
    {
      "mfussenegger/nvim-dap", -- Debug Adapter Protocol (DAP) for Neovim
      dependencies = {
        "rcarriga/nvim-dap-ui", -- UI for DAP
        "theHamsta/nvim-dap-virtual-text", -- Virtual text for debugging
      },
      config = function()
        require("dap").adapters.php = {
          type = "executable",
          command = "node",
          args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" },
        }
        require("dap").configurations.php = {
          {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            port = 9003,
            log = true,
          },
        }
      end,
    },

    -- Composer support
    {
      "noahfrederick/vim-composer", -- Composer integration for Vim
      ft = "php", -- Filetype detection for PHP files
    },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

-- Mason setup
require("mason").setup()
