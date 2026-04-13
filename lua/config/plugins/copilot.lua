return {
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_enabled = true
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_filetypes = { TelescopePrompt = false }

            vim.keymap.set('n', '<leader>go', ':Copilot<CR>',        { silent = true })
            vim.keymap.set('n', '<leader>ge', ':Copilot enable<CR>', { silent = true })
            vim.keymap.set('n', '<leader>gd', ':Copilot disable<CR>',{ silent = true })

            vim.keymap.set('i', '<c-p>', '<Plug>(copilot-suggest)',  {})
            vim.keymap.set('i', '<c-n>', '<Plug>(copilot-next)',     { silent = true })
            vim.keymap.set('i', '<c-b>', '<Plug>(copilot-previous)', { silent = true })
            vim.keymap.set('i', '<C-L>', function()
                return vim.fn["copilot#Accept"]("")
            end, { expr = true, silent = true, replace_keycodes = false })
        end
    }
}
