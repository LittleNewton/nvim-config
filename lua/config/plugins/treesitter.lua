-- Author: Peng Liu
-- Create Date: 27 Sept. 2023
-- Update Date: 27 Sept. 2023



return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local parsers = {
                "arduino", "bash", "bibtex", "c", "c_sharp", "cmake", "cpp",
                "css", "diff", "dockerfile", "git_config", "git_rebase",
                "gitattributes", "gitcommit", "gitignore", "go", "gpg", "html",
                "java", "javascript", "json", "lua", "make", "markdown",
                "prisma", "python", "query", "ruby", "rust", "sql",
                "ssh_config", "typescript", "vim", "vue", "yaml",
            }
            require("nvim-treesitter").install(parsers)

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(ev)
                    pcall(vim.treesitter.start, ev.buf)
                end,
            })

            local selection = {}
            local function set_visual(node)
                local srow, scol, erow, ecol = node:range()
                vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
                vim.cmd("normal! v")
                if ecol == 0 then
                    vim.api.nvim_win_set_cursor(0, { erow, -1 })
                else
                    vim.api.nvim_win_set_cursor(0, { erow + 1, ecol - 1 })
                end
            end
            local function init_selection()
                local node = vim.treesitter.get_node()
                if not node then return end
                selection = { node }
                set_visual(node)
            end
            local function node_incremental()
                local last = selection[#selection]
                if not last then return init_selection() end
                local parent = last:parent()
                if not parent then return end
                table.insert(selection, parent)
                set_visual(parent)
            end
            local function node_decremental()
                if #selection <= 1 then return end
                table.remove(selection)
                set_visual(selection[#selection])
            end
            local scope_types = {
                ["function_definition"] = true,
                ["function_declaration"] = true,
                ["method_definition"] = true,
                ["method_declaration"] = true,
                ["class_definition"] = true,
                ["class_declaration"] = true,
                ["if_statement"] = true,
                ["for_statement"] = true,
                ["while_statement"] = true,
                ["block"] = true,
            }
            local function scope_incremental()
                local last = selection[#selection]
                if not last then return init_selection() end
                local p = last:parent()
                while p and not scope_types[p:type()] do p = p:parent() end
                if not p then return end
                table.insert(selection, p)
                set_visual(p)
            end

            vim.keymap.set("n", "<c-n>", init_selection, { silent = true })
            vim.keymap.set("x", "<c-n>", node_incremental, { silent = true })
            vim.keymap.set("x", "<c-h>", node_decremental, { silent = true })
            vim.keymap.set("x", "<c-l>", scope_incremental, { silent = true })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            local tscontext = require('treesitter-context')
            tscontext.setup {
                enable = true,
                max_lines = 0,              -- How many lines the window should span. Values <= 0 mean no limit
                min_window_height = 0,      -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20,   -- Maximum number of lines to collapse for a single context line
                trim_scope = 'outer',       -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',            -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20,                -- The Z-index of the context window
                on_attach = nil,            -- (fun(buf: integer): boolean) return false to disable attaching
            }
            vim.keymap.set("n", "[c", function()
                tscontext.go_to_context()
            end, { silent = true })
        end
    },
}
