-- Author: Peng Liu
-- Email: littlenewton6@gmail.com
-- Create Date: 07 Apr. 2024
-- Update Date: 07 Apr. 2024



return {
    {
        "mbbill/undotree",
        keys = { "L" },
        config = function()
            vim.cmd([[
noremap L :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
	nmap <buffer> k <plug>UndotreeNextState
	nmap <buffer> j <plug>UndotreePreviousState
	nmap <buffer> K 5<plug>UndotreeNextState
	nmap <buffer> J 5<plug>UndotreePreviousState
endfunc]])
        end
    }
}
