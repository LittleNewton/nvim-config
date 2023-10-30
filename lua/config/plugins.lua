-- Author: Peng Liu
-- Create Date: 03 Oct. 2023
-- Update Date: 03 Oct. 2023



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

local lazy_cmd = require("lazy.view.config").commands
local lazy_keys = {
    { cmd = "install", key = "I" },
    { cmd = "update",  key = "lu" },
    { cmd = "sync",    key = "ls" },
    { cmd = "clean",   key = "lc" },
    { cmd = "check",   key = "lk" },
    { cmd = "log",     key = "lo" },
    { cmd = "restore", key = "rs" },
    { cmd = "profile", key = "pr" },
}
for _, v in ipairs(lazy_keys) do
    lazy_cmd[v.cmd].key = "<leader>" .. v.key
    lazy_cmd[v.cmd].key_plugin = "<leader>" .. v.key
end
vim.keymap.set("n", "<leader>pl", ":Lazy<CR>", { noremap = true })

require("lazy").setup({
    { "dstein64/vim-startuptime" },
    { "weirongxu/coc-explorer" },
    require("config.plugins.autocomplete").config,
    require("config.plugins.colorscheme"),
    require("config.plugins.comment"),
    require("config.plugins.copilot"),
    require("config.plugins.debugger"),
    require("config.plugins.editor"),
    require("config.plugins.flutter"),
    require("config.plugins.ft"),
    require("config.plugins.fun"),
    require("config.plugins.fzf"),
    require("config.plugins.git"),
    require("config.plugins.go"),
    require("config.plugins.indent"),
    require("config.plugins.joshuto"),
    require("config.plugins.leap"),
    require("config.plugins.lspconfig").config,
    require("config.plugins.markdown"),
    require("config.plugins.multi-cursor"),
    require("config.plugins.notify"),
    require("config.plugins.project"),
    require("config.plugins.scrollbar"),
    require("config.plugins.search"),
    require("config.plugins.snippets"),
    require("config.plugins.statusline"),
    require("config.plugins.surround"),
    require("config.plugins.tabline"),
    require("config.plugins.telescope").config,
    require("config.plugins.treesitter"),
    require("config.plugins.undo"),
    require("config.plugins.wilder"),
    require("config.plugins.winbar"),
    require("config.plugins.window-management"),
    require("config.plugins.yank"),
}, {
})

require("plugin.vertical_cursor_movement")

local swap_ternary = require("plugin.swap_ternary")
vim.keymap.set("n", "<leader>st", swap_ternary.swap_ternary, { noremap = true })

require("plugin.compile_run")
