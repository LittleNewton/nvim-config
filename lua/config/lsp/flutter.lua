local preview_stack_trace = function()
    local line = vim.api.nvim_get_current_line()
    local pattern = "package:[^/]+/([^:]+):(%d+):(%d+)"
    local filepath, line_nr, column_nr = string.match(line, pattern)
    if filepath and line_nr and column_nr then
        vim.cmd(":wincmd k")
        vim.cmd("e " .. filepath)
        vim.api.nvim_win_set_cursor(0, { tonumber(line_nr), tonumber(column_nr) })
        vim.cmd(":wincmd j")
    end
end

return function(base_opts)
    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "__FLUTTER_DEV_LOG__",
        callback = function()
            vim.keymap.set("n", "p", preview_stack_trace, { silent = true, noremap = true, buffer = true })
        end
    })

    local ok, flutter = pcall(require, 'flutter-tools')
    if not ok then
        return
    end

    local capabilities = base_opts and base_opts.capabilities or nil
    local base_on_attach = base_opts and base_opts.on_attach or nil

    flutter.setup({
        fvm = true,
        widget_guides = {
            enabled = true,
        },
        ui = {
            border = "rounded",
            notification_style = 'nvim-notify'
        },
        lsp = {
            on_attach = function(client, bufnr)
                if base_on_attach then
                    base_on_attach(client, bufnr)
                end
                vim.cmd('highlight! link FlutterWidgetGuides Comment')
            end,
            capabilities = capabilities,
            settings = {
                enableSnippets = false,
                showTodos = true,
                completeFunctionCalls = true,
                analysisExcludedFolders = {
                    vim.fn.expand '$HOME/.pub-cache',
                    vim.fn.expand '$HOME/fvm',
                },
                lineLength = 100,
            },
        },
        dev_log = {
            enabled = true,
            notify_errors = true,
            open_cmd = "e",
        },
        debugger = {
            enabled = true,
            run_via_dap = true,
            exception_breakpoints = {
                {
                    filter = 'raised',
                    label = 'Exceptions',
                    condition =
                    "!(url:startsWith('package:flutter/') || url:startsWith('package:flutter_test/') || url:startsWith('package:dartpad_sample/') || url:startsWith('package:flutter_localizations/'))"
                }
            },
            register_configurations = function(_)
                local dap = require("dap")
                if not dap.configurations.dart then
                    dap.adapters.dart = {
                        type = "executable",
                        command = "flutter",
                        args = { "debug_adapter" }
                    }
                    dap.configurations.dart = {
                        {
                            type = "dart",
                            request = "launch",
                            name = "Launch Flutter Program",
                            program = "lib/main.dart",
                            cwd = "${workspaceFolder}",
                            toolArgs = { "-d", "macos" }
                        }
                    }
                end
                require("dap.ext.vscode").load_launchjs()
            end,
        },
    })
end
