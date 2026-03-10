return function()
    return {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        'vim',
                        'require',
                    },
                },
                workspace = {
                    checkThirdParty = false,
                },
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    }
end
