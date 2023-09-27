-- Author: Peng Liu
-- Create Date: 27 Sept. 2023
-- Update Date: 27 Sept. 2023



vim.g.mapleader = " "

local mode_nv = { "n", "v" }
local mode_v  = { "v" }
local mode_i  = { "i" }

local nmappings = {
    { from = "S",             to = ":w<CR>" },
    { from = "Q",             to = ":q<CR>" },
    { from = ";",             to = ":",                                                                   mode = mode_nv },
    { from = "Y",             to = "\"+y",                                                                mode = mode_v },
    { from = "`",             to = "~",                                                                   mode = mode_nv },

    -- Movement
    { from = "J",             to = "5j",                                                                  mode = mode_nv },
    { from = "K",             to = "5k",                                                                  mode = mode_nv },

    -- Useful actions
    { from = ",.",            to = "%",                                                                   mode = mode_nv },
    { from = "<c-y>",         to = "<ESC>A {}<ESC>i<CR><ESC>ko",                                          mode = mode_i  },
    { from = "\\v",           to = "v$h", },
    { from = "<c-a>",         to = "<ESC>A",                                                              mode = mode_i  },

    -- Window & splits
    { from = "<leader>w",     to = "<C-w>w", },
    { from = "qf",            to = "<C-w>o", },
    { from = "s",             to = "<nop>", },
    { from = "sk",            to = ":set nosplitbelow<CR>:split<CR>:set splitbelow<CR>", },
    { from = "sj",            to = ":set splitbelow<CR>:split<CR>", },
    { from = "sh",            to = ":set nosplitright<CR>:vsplit<CR>:set splitright<CR>", },
    { from = "sl",            to = ":set splitright<CR>:vsplit<CR>", },
    { from = "<up>",          to = ":res +5<CR>", },
    { from = "<down>",        to = ":res -5<CR>", },
    { from = "<left>",        to = ":vertical resize-5<CR>", },
    { from = "<right>",       to = ":vertical resize+5<CR>", },
    -- { from = "sh",            to = "se", },
    -- { from = "sh",            to = "<C-w>t<C-w>K", },
    -- { from = "sv",            to = "<C-w>t<C-w>H", },
    { from = "srh",           to = "<C-w>b<C-w>K", },
    { from = "srv",           to = "<C-w>b<C-w>H", },

    -- Tab management
    { from = "<leader>u",            to = ":tabe<CR>", },
    { from = "<leader>U",            to = ":tab split<CR>", },
    { from = "<leader>hh",           to = ":-tabnext<CR>", },
    { from = "<leader>l",            to = ":+tabnext<CR>", },
    { from = "<leader>mh",           to = ":-tabmove<CR>", },
    { from = "<leader>ml",           to = ":+tabmove<CR>", },

    -- Other
    { from = "<leader>sw",    to = ":set wrap<CR>" },
    { from = "<leader><CR>",  to = ":nohlsearch<CR>" },
    { from = "<f10>",         to = ":TSHighlightCapturesUnderCursor<CR>" },
    { from = "<leader>o",     to = "za" },
    { from = "<leader>pr",    to = ":profile start profile.log<CR>:profile func *<CR>:profile file *<CR>" },
    { from = "<leader>rc",    to = ":e ~/.config/nvim/init.lua<CR>" },
    { from = "<leader>rv",    to = ":e .vim.lua<CR>" },
    { from = ",v",            to = "v%" },
    { from = "<leader><esc>", to = "<nop>" },

    -- Joshuto
    { from = "R",             to = ":Joshuto<CR>" },
}

for _, mapping in ipairs(nmappings) do
    vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end

local function run_vim_shortcut(shortcut)
    local escaped_shortcut = vim.api.nvim_replace_termcodes(shortcut, true, false, true)
    vim.api.nvim_feedkeys(escaped_shortcut, 'n', true)
end

-- close win below
vim.keymap.set("n", "<leader>q", function()
    vim.cmd("TroubleClose")
    local wins = vim.api.nvim_tabpage_list_wins(0)
    if #wins > 1 then
        run_vim_shortcut([[<C-w>j:q<CR>]])
    end
end, { noremap = true, silent = true })
