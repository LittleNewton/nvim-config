-- Author: Peng Liu
-- Email: littlenewton6@gmail.com
-- Create Date: 07 Apr. 2024
-- Update Date: 07 Apr. 2024



return {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme dracula]])
    end,
}
