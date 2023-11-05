-- Author: Peng Liu
-- Email: littlenewton6@gmail.com
-- Create Date: 05 Nov. 2023
-- Update Date: 05 Nov. 2023



return {
    "numToStr/Comment.nvim",
    config = function()
        local api = require("Comment.api")

        -- Set keybindings for normal mode.
        vim.keymap.set("n", "<leader>nn", api.locked("comment.linewise.current"))
        vim.keymap.set("n", "<leader>uu", api.locked("uncomment.linewise.current"))
        vim.keymap.set("n", "<leader>cc", api.locked("toggle.blockwise.current"))

        -- Set keybindings for visual block mode.
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.keymap.set('x', '<leader>nn', function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.locked('comment.linewise')(vim.fn.visualmode())
        end)
        vim.keymap.set('x', '<leader>uu', function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.locked('uncomment.linewise')(vim.fn.visualmode())
        end)
        vim.keymap.set('x', '<leader>cc', function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.locked('toggle.blockwise')(vim.fn.visualmode())
        end)

        -- padding.
        require('Comment').setup({
            -- Add padding between comment contents and comment delimiters.
            padding = true,

            -- Keep indention when adding comment.
            sticky = true,

            -- Disable default keybindings.
            mappings = {
                basic = false,
                extra = false,
            },
        })
    end
}
