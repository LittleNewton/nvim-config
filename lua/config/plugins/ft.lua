-- Author: Peng Liu
-- Email: littlenewton6@gmail.com
-- Create Date: 09 Nov. 2023
-- Update Date: 09 Nov. 2023



return {
    {
        "dart-lang/dart-vim-plugin",
        ft = "dart",
        config = function()
            vim.g.dart_corelib_highlight = false
            vim.g.dart_format_on_save = false
        end
    }
}
