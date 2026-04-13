return {
    {
        "mbbill/undotree",
        keys = { "L" },
        config = function()
            vim.keymap.set("n", "L", ":UndotreeToggle<CR>", { noremap = true })
            vim.g.undotree_DiffAutoOpen = 1
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_ShortIndicators = 1
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_DiffpanelHeight = 8
            vim.g.undotree_SplitWidth = 24
            vim.g.Undotree_CustomMap = function()
                vim.keymap.set("n", "k", "<Plug>UndotreeNextState",     { buffer = true })
                vim.keymap.set("n", "j", "<Plug>UndotreePreviousState", { buffer = true })
                vim.keymap.set("n", "K", "5<Plug>UndotreeNextState",    { buffer = true })
                vim.keymap.set("n", "J", "5<Plug>UndotreePreviousState",{ buffer = true })
            end
        end
    }
}
