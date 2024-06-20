-- ident setting
vim.opt.ts = 4
vim.opt.sw = 4
vim.opt.expandtab = true
vim.opt.cin = true

-- buffer setting
vim.opt.hidden = true
vim.opt.aw = true

-- line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_create_autocmd({"InsertEnter"},{
    pattern = '*',
    command = "set norelativenumber",
})
vim.api.nvim_create_autocmd({"InsertLeave"},{
    pattern = '*',
    command = "set relativenumber",
})

-- disable auto comment
vim.api.nvim_create_autocmd({"BufEnter"},{
    pattern = '*',
    command = "set formatoptions-=cro",
})

-- change leader
vim.g.mapleader = ' '

require("configs.keymap")

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
