return {
    "petertriho/nvim-scrollbar",
    dependencies = {
        "kevinhwang91/nvim-hlslens",
    },
    config = function()
        local group = vim.api.nvim_create_augroup("scrollbar_set_git_colors", {})
        vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*",
            callback = function()
                vim.api.nvim_set_hl(0, "ScrollbarGitAdd",          { fg = "#8CC85F" })
                vim.api.nvim_set_hl(0, "ScrollbarGitAddHandle",    { fg = "#A0CF5D" })
                vim.api.nvim_set_hl(0, "ScrollbarGitChange",       { fg = "#E6B450" })
                vim.api.nvim_set_hl(0, "ScrollbarGitChangeHandle", { fg = "#F0C454" })
                vim.api.nvim_set_hl(0, "ScrollbarGitDelete",       { fg = "#F87070" })
                vim.api.nvim_set_hl(0, "ScrollbarGitDeleteHandle", { fg = "#FF7B7B" })
            end,
            group = group,
        })
        require("scrollbar.handlers.search").setup({})
        require("scrollbar.handlers.gitsigns").setup()
        require("scrollbar").setup({
            show = true,
            handle = {
                text = " ",
                color = "#928374",
                hide_if_all_visible = true,
            },
            marks = {
                Search = { color = "yellow" },
                Misc = { color = "purple" },
            },
            handlers = {
                cursor = false,
                diagnostic = true,
                gitsigns = true,
                handle = true,
                search = true,
            },
        })
    end,
}
