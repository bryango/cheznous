-- the ultimate final init file
-- init chain:
--   ~/.vimrc  ->  ~/.config/nvim/source.vim
--             ->  ~/.config/nvim/init.lua
vim.cmd([[
    source ~/.config/nvim/source.vim
]])

-- -- grammarly
-- require'lspconfig'.grammarly.setup{
--     filetypes = { "markdown", "gitcommit" },
-- }

-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
-- 
-- require("indent_blankline").setup {
--     show_end_of_line = true,
--     space_char_blankline = " ",
-- }
