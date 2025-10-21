return function()
    local ok, neodev = pcall(require, "neodev")
    if ok then
        neodev.setup({})
    end

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
