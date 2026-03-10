-- Author: Peng Liu
-- Create Date: 27 Sept. 2023
-- Update Date: 21 Oct.  2025



local M = {}
local F = {}

local ensure_servers = {
    'eslint',        -- eslint-lsp
    'gopls',         -- Go
    'jsonls',        -- JSON
    'lua_ls',        -- Lua
    'rust_analyzer', -- Rust
    'ts_ls',         -- typescript-language-server
}

local server_overrides = {
    lua_ls = require("config.lsp.lua"),
    jsonls = require("config.lsp.json"),
}

local format_on_save_filetypes = {
    dart = true,
    json = true,
    go = true,
    lua = true,
}

M.config = {
    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                "folke/trouble.nvim",
                opts = {
                    use_diagnostic_signs = true,
                    action_keys = {
                        close = "<esc>",
                        previous = "u",
                        next = "e"
                    },
                },
            },
            { 'williamboman/mason.nvim', build = function() vim.cmd([[MasonInstall]]) end },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'j-hui/fidget.nvim' },
            {
                'folke/lazydev.nvim',
                ft = 'lua',
                opts = {},
            },
            'ldelossa/nvim-dap-projects',
        },
        config = function()
            F.setup_lsp()
        end
    },
}

function F.setup_lsp()
    F.setup_mason()
    F.setup_diagnostics()
    F.configure_doc_and_signature()
    F.configure_keybinds()
    F.setup_format_on_save()

    local base_opts = F.base_options()
    F.setup_servers(base_opts)
    F.setup_flutter(base_opts)
    F.setup_auxiliary_tools()
end

function F.setup_mason()
    local mason_ok, mason = pcall(require, "mason")
    if mason_ok then
        mason.setup()
    end

    local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if mason_lspconfig_ok then
        mason_lspconfig.setup({
            ensure_installed = ensure_servers,
            automatic_enable = false,
        })
    end
end

function F.base_options()
    local ok, cmp = pcall(require, 'cmp_nvim_lsp')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    if ok then
        capabilities = cmp.default_capabilities(capabilities)
    end

    return {
        capabilities = capabilities,
        on_attach = F.on_attach,
        on_init = F.on_init,
    }
end

function F.setup_servers(base_opts)
    for name, builder in pairs(server_overrides) do
        local overrides = builder()
        local config = F.merge_options(base_opts, overrides)
        F.register_server(name, config)
    end

    for _, name in ipairs(ensure_servers) do
        if not server_overrides[name] then
            local config = F.merge_options(base_opts, {})
            F.register_server(name, config)
        end
    end
end

function F.setup_flutter(base_opts)
    local ok, configure_flutter = pcall(require, "config.lsp.flutter")
    if ok then
        configure_flutter(base_opts)
    end
end

function F.register_server(name, config)
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end

function F.merge_options(base_opts, overrides)
    local overrides_copy = vim.deepcopy(overrides or {})
    local custom_on_attach = overrides_copy.on_attach
    overrides_copy.on_attach = nil
    local custom_on_init = overrides_copy.on_init
    overrides_copy.on_init = nil

    local merged = vim.tbl_deep_extend('force', {}, base_opts, overrides_copy)

    local base_on_attach = base_opts.on_attach
    if custom_on_attach then
        merged.on_attach = function(client, bufnr)
            if base_on_attach then
                base_on_attach(client, bufnr)
            end
            custom_on_attach(client, bufnr)
        end
    end

    local base_on_init = base_opts.on_init
    if custom_on_init then
        merged.on_init = function(client, ...)
            if base_on_init then
                base_on_init(client, ...)
            end
            return custom_on_init(client, ...)
        end
    end

    return merged
end

function F.disable_semantic_tokens(client)
    if client and client.server_capabilities then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

function F.on_init(client)
    F.disable_semantic_tokens(client)
end

function F.on_attach(client, bufnr)
    F.disable_semantic_tokens(client)

    if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    local ok, autocomplete = pcall(require, "config.plugins.autocomplete")
    if ok and type(autocomplete.configfunc) == "function" then
        autocomplete.configfunc()
    end
end

function F.setup_diagnostics()
    vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN]  = "▲",
                [vim.diagnostic.severity.HINT]  = "⚑",
                [vim.diagnostic.severity.INFO]  = "»",
            },
        },
        virtual_text = false,
        update_in_insert = false,
        float = true,
    })
end

function F.setup_format_on_save()
    local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = group,
        pattern = "*",
        callback = function()
            local ft = vim.bo.filetype
            if format_on_save_filetypes[ft] then
                local cursor = vim.api.nvim_win_get_cursor(0)
                vim.lsp.buf.format({ async = false })
                vim.api.nvim_win_set_cursor(0, cursor)
            end
        end,
    })
end

function F.setup_auxiliary_tools()
    local ok_fidget, fidget = pcall(require, "fidget")
    if ok_fidget then
        fidget.setup({})
    end

    local ok_projects, dap_projects = pcall(require, "nvim-dap-projects")
    if ok_projects then
        dap_projects.search_project_config()
    end
end

function F.configure_doc_and_signature()
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {
            silent = true,
            focusable = false,
            border = "rounded",
        }
    )

    local group = vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
        pattern = "*",
        group = group,
        callback = function()
            vim.diagnostic.open_float(0, {
                scope = "cursor",
                focusable = false,
                close_events = {
                    "CursorMoved",
                    "CursorMovedI",
                    "BufHidden",
                    "InsertCharPre",
                    "WinLeave",
                },
            })
        end,
    })
end

function F.configure_keybinds()
    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
            local opts = { buffer = event.buf, noremap = true, nowait = true }

            vim.keymap.set('n', '<leader>ho', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gD', ':tab sp<CR><cmd>lua vim.lsp.buf.definition()<cr>', opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<leader>aw', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', "<leader>,", vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>t', ':Trouble<cr>', opts)
            vim.keymap.set('n', '<leader>-', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', '<leader>=', vim.diagnostic.goto_next, opts)
        end
    })
end

return M
