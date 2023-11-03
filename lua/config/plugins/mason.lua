-- Author: Peng Liu
-- Create Date: 27 Sept. 2023
-- Update Date: 27 Sept. 2023



return {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
        { "williamboman/mason.nvim", build = ":MasonUpdate", },
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", },
            automatic_installation = true,
        })
    end
}
