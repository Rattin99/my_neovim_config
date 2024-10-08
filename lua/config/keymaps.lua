-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Toggle the terminal with <leader>tt
vim.api.nvim_set_keymap("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true })

-- Open a terminal in a split window with <leader>t
vim.api.nvim_set_keymap("n", "<leader>t", ":botright split | terminal<CR>", { noremap = true, silent = true })
