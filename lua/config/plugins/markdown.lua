-- Author: Peng Liu
-- Email: littlenewton6@gmail.com
-- Create Date: 06 Nov. 2023
-- Update Date: 06 Nov. 2023



return {
    {
        "instant-markdown/vim-instant-markdown",
        ft = { "markdown" },
        build = "yarn install",
        config = function()
            vim.g.instant_markdown_slow                   = 1
            vim.g.instant_markdown_autostart              = 1
            vim.g.instant_markdown_open_to_the_world      = 1
            vim.g.instant_markdown_allow_unsafe_content   = 1
            vim.g.instant_markdown_allow_external_content = 1
            vim.g.instant_markdown_mathjax                = 1
            vim.g.instant_markdown_mermaid                = 1
            vim.g.instant_markdown_logfile                = '/tmp/instant-markdown.log'
            vim.g.instant_markdown_autoscroll             = 0
            vim.g.instant_markdown_port                   = 8888
            vim.g.instant_markdown_python                 = 1
            vim.g.instant_markdown_theme                  = 'dark'
        end,
    },
}
