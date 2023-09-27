-- Author: Peng Liu
-- Create Date: 27 Sept. 2023
-- Update Date: 27 Sept. 2023



return {
    "theniceboy/joshuto.nvim",
    cmd = "Joshuto",
    config = function()
        vim.g.joshuto_floating_window_scaling_factor = 1.0
        vim.g.joshuto_use_neovim_remote = 1
        vim.g.joshuto_floating_window_winblend = 0
    end
}
