-- Author: Peng Liu
-- Create Date: 27 Sept. 2023
-- Update Date: 27 Sept. 2023



return {
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_enabled = true
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap('n', '<leader>go',  ':Copilot<CR>',         { silent = true })
            vim.api.nvim_set_keymap('n', '<leader>ge',  ':Copilot enable<CR>',  { silent = true })
            vim.api.nvim_set_keymap('n', '<leader>gd',  ':Copilot disable<CR>', { silent = true })

            vim.api.nvim_set_keymap('i', '<c-p>',   '<Plug>(copilot-suggest)',  {})
            vim.api.nvim_set_keymap('i', '<c-n>',   '<Plug>(copilot-next)',     { silent = true })
            vim.api.nvim_set_keymap('i', '<c-l>',   '<Plug>(copilot-previous)', { silent = true })
            vim.cmd('imap <silent><script><expr> <C-L> copilot#Accept("")')
            vim.cmd([[
            let g:copilot_filetypes = {
                \ 'TelescopePrompt': v:false,
                \ }
            ]])
        end
    }
}
