return {
    "mg979/vim-visual-multi",
    init = function()
        vim.g.VM_leader = { default = ',', visual = ',', buffer = ',' }
        vim.g.VM_maps = {
            ["Find Under"]         = '<C-k>',
            ["Find Subword Under"] = '<C-k>',
            ["Find Next"]          = '',
            ["Find Prev"]          = '',
            ["Remove Region"]      = 'q',
            ["Skip Region"]        = '<c-n>',
            ["Undo"]               = 'l',
            ["Redo"]               = '<C-r>',
        }
        vim.keymap.set("n", "<leader>sa", "<Plug>(VM-Select-All)", { noremap = true })
    end
}
