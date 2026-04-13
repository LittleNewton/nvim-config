return {
    {
        "airblade/vim-rooter",
        init = function()
            vim.g.rooter_patterns = { '__vim_project_root', '.git/' }
            vim.g.rooter_silent_chdir = true
            vim.api.nvim_create_autocmd("VimEnter", {
                pattern = "*",
                callback = function()
                    local f = vim.fn.getcwd() .. "/.vim.lua"
                    if vim.uv.fs_stat(f) then
                        pcall(dofile, f)
                    end
                end,
            })
        end
    },
}
