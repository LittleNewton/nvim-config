local function split()
    vim.o.splitbelow = true
    vim.cmd.split()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_height(win, math.max(vim.api.nvim_win_get_height(win) - 5, 5))
end

local function compile_run()
    vim.cmd.write()
    local ft = vim.bo.filetype
    if ft == "markdown" then
        vim.cmd("InstantMarkdownPreview")
    elseif ft == "lua" then
        split()
        vim.cmd.terminal("luajit %")
    end
end

vim.keymap.set('n', 'r', compile_run, { silent = true })
