return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local ls = require("luasnip")
            ls.config.setup({})

            -- Load VSCode-style snippets from friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Load existing UltiSnips-format snippets from UltiSnips/ dir
            require("luasnip.loaders.from_snipmate").lazy_load()

            -- Custom snippets
            local s = ls.snippet
            local f = ls.function_node

            ls.add_snippets("all", {
                s("date", { f(function() return os.date("%Y-%m-%d") end) }),
                s("time", { f(function() return os.date("%H:%M") end) }),
                s("datetime", { f(function() return os.date("%Y-%m-%d %H:%M") end) }),
            })
        end
    },
}
