local function make_pair()
    local line = vim.api.nvim_get_current_line()
    local last_char = line:sub(-1)
    if last_char == ";" or last_char == "," then
        vim.cmd.normal({ "lx$P", bang = true })
    else
        vim.cmd.normal({ "lx$p", bang = true })
    end
end

vim.keymap.set("i", "<c-u>", function()
    vim.cmd.stopinsert()
    make_pair()
end, { noremap = true })

return {
    {
        "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure({
                providers = {
                    -- 'lsp',
                    -- 'treesitter',
                    'regex',
                },
            })
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#393E4D" })
        end
    },
    {
        "dkarter/bullets.vim",
        lazy = false,
        ft = { "markdown", "txt" },
    },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true,           -- #RGB hex codes
                RRGGBB = true,        -- #RRGGBB hex codes
                names = true,         -- "Name" codes like Blue or blue
                RRGGBBAA = false,     -- #RRGGBBAA hex codes
                AARRGGBB = true,      -- 0xAARRGGBB hex codes
                rgb_fn = false,       -- CSS rgb() and rgba() functions
                hsl_fn = false,       -- CSS hsl() and hsla() functions
                css = false,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = false,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
                mode = "virtualtext",
                tailwind = true,
                sass = { enable = false },
                virtualtext = "■",
            },
            buftypes = {},
        }
    },
    { 'theniceboy/antovim', lazy = false, },
    { 'gcmt/wildfire.vim',  lazy = false, },
    {
        "fedepujol/move.nvim",
        config = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<c-y>', ':MoveLine(1)<CR>', opts)
            vim.keymap.set('n', '<c-l>', ':MoveLine(-1)<CR>', opts)
            vim.keymap.set('v', '<c-e>', ':MoveBlock(1)<CR>', opts)
            vim.keymap.set('v', '<c-u>', ':MoveBlock(-1)<CR>', opts)
        end
    },
    {
        "gbprod/substitute.nvim",
        config = function()
            local substitute = require("substitute")
            substitute.setup({
                on_substitute = require("yanky.integration").substitute(),
                highlight_substituted_text = {
                    enabled = true,
                    timer = 200,
                },
            })
            vim.keymap.set("n", "s", substitute.operator, { noremap = true })
            vim.keymap.set("n", "sh", function() substitute.operator({ motion = "e" }) end, { noremap = true })
            vim.keymap.set("x", "s", require('substitute.range').visual, { noremap = true })
            vim.keymap.set("n", "ss", substitute.line, { noremap = true })
            vim.keymap.set("n", "sI", substitute.eol, { noremap = true })
            vim.keymap.set("x", "s", substitute.visual, { noremap = true })
        end
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async", },
        config = function() require('ufo').setup() end
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end
    },
}
