return {
    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            local hlslens = require('hlslens')
            hlslens.setup({
                build_position_cb = function(plist, _, _, _)
                    require("scrollbar.handlers.search").handler.show(plist.start_pos)
                end,
            })
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '=', function()
                vim.cmd.normal({ vim.v.count1 .. 'n', bang = true })
                hlslens.start()
            end, opts)
            vim.keymap.set('n', '-', function()
                vim.cmd.normal({ vim.v.count1 .. 'N', bang = true })
                hlslens.start()
            end, opts)
            vim.keymap.set('n', '*',  '*<Cmd>lua require("hlslens").start()<CR>',  opts)
            vim.keymap.set('n', '#',  '#<Cmd>lua require("hlslens").start()<CR>',  opts)
            vim.keymap.set('n', 'g*', 'g*<Cmd>lua require("hlslens").start()<CR>', opts)
            vim.keymap.set('n', 'g#', 'g#<Cmd>lua require("hlslens").start()<CR>', opts)
            vim.keymap.set('n', '<Leader><CR>', '<Cmd>noh<CR>', opts)
        end
    },
    {
        "pechorin/any-jump.vim",
        config = function()
            vim.keymap.set("n", "<leader>j", ":AnyJump<CR>", { noremap = true })
            vim.keymap.set("x", "<leader>j", ":AnyJumpVisual<CR>", { noremap = true })
            vim.g.any_jump_disable_default_keybindings = true
            vim.g.any_jump_window_width_ratio = 0.9
            vim.g.any_jump_window_height_ratio = 0.9
        end
    },
    {
        "nvim-pack/nvim-spectre",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            {
                "<leader>F",
                mode = "n",
                function()
                    require("spectre").open()
                end,
                desc = "Project find and replace"
            }
        }
    }
}
