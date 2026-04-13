vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.o.autochdir = true
vim.o.exrc = true
vim.o.secure = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.expandtab = false
vim.o.tabstop = 2
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.autoindent = true
vim.o.list = true
vim.o.listchars = 'tab:|\\ ,trail:▫'
vim.o.scrolloff = 4
vim.o.ttimeoutlen = 0
vim.o.timeout = false
vim.o.viewoptions = 'cursor,folds,slash,unix'
vim.o.wrap = true
vim.o.textwidth = 0
vim.o.indentexpr = ''
vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.o.foldenable = true
vim.o.foldlevelstart = 99
vim.o.formatoptions = vim.o.formatoptions:gsub('tc', '')
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.inccommand = 'split'
vim.o.completeopt = 'longest,noinsert,menuone,noselect,preview'
vim.o.completeopt = 'menuone,noinsert,noselect,preview'
-- vim.o.lazyredraw = true
vim.o.visualbell = true
vim.o.colorcolumn = '100'
vim.o.updatetime = 100
vim.o.virtualedit = 'block'

local nvim_dir = vim.fn.stdpath("config")
vim.fn.mkdir(nvim_dir .. "/tmp/backup", "p")
vim.fn.mkdir(nvim_dir .. "/tmp/undo", "p")
vim.o.backupdir = nvim_dir .. "/tmp/backup,."
vim.o.directory = nvim_dir .. "/tmp/backup,."
vim.o.undofile = true
vim.o.undodir = nvim_dir .. "/tmp/undo,."

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.md",
    callback = function() vim.opt_local.spell = true end,
})
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        pcall(function() vim.cmd.lcd(vim.fn.expand("%:p:h")) end)
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)
        if mark[1] > 1 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
})

vim.g.terminal_color_0  = '#000000'
vim.g.terminal_color_1  = '#FF5555'
vim.g.terminal_color_2  = '#50FA7B'
vim.g.terminal_color_3  = '#F1FA8C'
vim.g.terminal_color_4  = '#BD93F9'
vim.g.terminal_color_5  = '#FF79C6'
vim.g.terminal_color_6  = '#8BE9FD'
vim.g.terminal_color_7  = '#BFBFBF'
vim.g.terminal_color_8  = '#4D4D4D'
vim.g.terminal_color_9  = '#FF6E67'
vim.g.terminal_color_10 = '#5AF78E'
vim.g.terminal_color_11 = '#F4F99D'
vim.g.terminal_color_12 = '#CAA9FA'
vim.g.terminal_color_13 = '#FF92D0'
vim.g.terminal_color_14 = '#9AEDFE'

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    command = "startinsert",
})

local nvimrc_group = vim.api.nvim_create_augroup("NVIMRC", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    group = nvimrc_group,
    pattern = ".vim.lua",
    command = "source %",
})

vim.keymap.set("t", "<C-N>", [[<C-\><C-N>]], { noremap = true })
vim.keymap.set("t", "<C-O>", [[<C-\><C-N><C-O>]], { noremap = true })

vim.api.nvim_set_hl(0, "NonText", { ctermfg = 8, fg = "grey10" })

local config_path = vim.fn.stdpath("config")
local current_config_path = config_path .. "/lua/config/machine_specific.lua"
if not vim.uv.fs_stat(current_config_path) then
    local current_config_file = io.open(current_config_path, "wb")
    local default_config_path = config_path .. "/default_config/_machine_specific_default.lua"
    local default_config_file = io.open(default_config_path, "rb")
    if default_config_file and current_config_file then
        local content = default_config_file:read("*all")
        current_config_file:write(content)
        io.close(default_config_file)
        io.close(current_config_file)
    end
end
require("config.machine_specific")

-- Workaround: Neovim 0.12.0 treesitter async parse can pass nil nodes
-- to get_range(), causing "attempt to call method 'range' (a nil value)".
-- Remove this after upgrading to a Neovim version that fixes the bug.
do
    local orig = vim.treesitter.get_range
    vim.treesitter.get_range = function(node, source, metadata)
        if node == nil then
            return { 0, 0, 0, 0, 0, 0 }
        end
        return orig(node, source, metadata)
    end
end
