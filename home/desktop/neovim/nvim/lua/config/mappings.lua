local map = vim.keymap.set
local defaults = { noremap = true, silent = true }

vim.g.mapleader = " ";

map("n", "<leader>e", vim.cmd.Ex, defaults)
