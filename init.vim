" 基本配置
    " Tab可视化，结尾空格可视化
    set list
    set listchars=tab:▸\ ,trail:·

    set number     " 行号
    set ttyfast    " 滚动更快
    set lazyredraw " 滚动更快
    syntax on      " 语法高亮

    "Vim自动探测fileencodings的顺序列表
    "启动时会按照它所列出的字符编码方式逐一探测即将打开的文件的字符编码方式
    "并且将fileencoding设置为最终探测到的字符编码方式
    set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
    set termencoding=utf-8              " Vim所工作的终端的字符编码方式

    set autoindent                      " 自动缩进

    set expandtab                       " 用空格代替Tab
    set tabstop=4                       " Tab键显示的宽度
    set shiftwidth=4                    " Tab键显示的宽度

    set showmatch                       " 高亮显示匹配的括号
    set hlsearch                        " 高亮匹配结果
    set ignorecase                      " 搜索时默认忽略大小写
    set smartcase                       " 搜索时智能匹配大小写

    set nobackup                        " 不保存备份文件
    set noswapfile                      " 不保存交换文件
    set undofile                        " 保存历史文件
    set undodir=~/.config/nvim/.undodir " 历史文件位置
    set undolevels=1000                 " 设置最大撤销记录数

    set autoread                        " 文件变化之后自动重读
    set wildmenu                        " 启用命令行模式下自动补全
    set noautochdir                     " 进入Vim不切换到文件所在目录

    " 打开文件时光标返回上次离开的位置
    autocmd BufReadPost * execute "normal g'\""

" 按键映射
    " 修改默认键
        nnoremap Y y$
    " 重载操作
        map <c-s>                           <nop>
        map <c-q>                           <nop>
        " Ctrl+S：保存
        nmap <c-s>                          :w<cr>
        " Ctrl+Q：退出
        nmap <c-q>                          :q<cr>
        " F5：丢失更改重新读取
        nnoremap <F5>                       :e!<cr>
        " Ctrl+y：复制到剪切板
        vmap <c-y>                          "+y
        nmap <c-y>                          "+y
        " Ctrl+p：从剪切板中粘贴
        vmap <c-p>                          "+p
        nmap <c-p>                          "+p

    " Leader键设置为空格键
        let mapleader=' '
        nmap <leader>                       <nop>

    " s键作为二级按键
        nmap s                              <nop>
        " sn = 取消高亮
        nnoremap <silent> sn                :nohl<cr>
        " sq = 关闭当前缓冲区
        nnoremap <silent> sq                :bd<cr>
        " se = 反转wrap
        nnoremap se                         :set wrap!<cr>
        " sf = 手动定义文件类型
        nnoremap sf                         :set filetype=

    " 把反斜杠重定义为调用宏
        nnoremap \                          @q
        nnoremap \|                         @w

    " 移动居中
        nnoremap j                          jzz
        nnoremap k                          kzz
        nnoremap {                          {zz
        nnoremap }                          }zz
        nnoremap [[                         [[zz
        nnoremap ]]                         ]]zz
        nnoremap G                          Gzz
        nnoremap n                          nzz
        nnoremap N                          Nzz
        nnoremap w                          wzz
        nnoremap b                          bzz
        nnoremap *                          *zz
        nnoremap #                          #zz
        nnoremap %                          %zz
        nnoremap zi                         zizz
        nnoremap <c-d>                      <c-d>zz
        nnoremap <c-u>                      <c-u>zz
        nnoremap _                          -zz
        nnoremap +                          +zz
        nnoremap ``                         ``zz

    "在多窗口之间移动光标
        nnoremap <leader>h                  <c-w>h
        nnoremap <leader>j                  <c-w>j
        nnoremap <leader>k                  <c-w>k
        nnoremap <leader>l                  <c-w>l

    " 插入模式下连按jk = 退出插入模式
        imap jk <esc>

" 插件定义
    " 插件正常工作配置
        set nocompatible
        filetype on
        filetype indent on
        filetype plugin on
        filetype plugin indent on

call plug#begin('~/.config/nvim/plugged')
    " 外观
    Plug 'vim-airline/vim-airline'
    Plug 'dracula/vim'
    " 高亮当前光标下的词
    Plug 'RRethy/vim-illuminate'

    " coc补全框架
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " 中文vim文档
    Plug 'yianwillis/vimcdoc'

    " nerdtree
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " ranger
    Plug 'rbgrouleff/bclose.vim'
    Plug 'francoiscabrol/ranger.vim'

    " lazygit
    Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }

    " undotree
    Plug 'mbbill/undotree'

    " bookmark
    Plug 'kshenoy/vim-signature'

    " startify 起始页
    Plug 'mhinz/vim-startify'

    " comment 快速注释
    Plug 'scrooloose/nerdcommenter'

    " clipboard 寄存器面板
    Plug 'junegunn/vim-peekaboo'

    " fzf
    Plug 'junegunn/fzf.vim'

    " clever-f fFtT增强
    Plug 'rhysd/clever-f.vim'
call plug#end()

" 插件配置

    " vim-airline
        let g:airline#extensions#coc#enabled = 1
        let g:airline#extensions#branch#enabled = 1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#show_buffers = 1
        let g:airline#extensions#tabline#formatter = 'unique_tail'
        let g:airline#extensions#tabline#tab_nr_type = 1
        let g:airline#extensions#tabline#show_tab_nr = 1
        let g:airline#extensions#tabline#fnametruncate = 16
        let g:airline#extensions#tabline#fnamecollapse = 2
        let g:airline#extensions#tabline#buffer_idx_mode = 1
        let g:airline#extensions#tabline#buffer_nr_show = 0
        let g:airline_powerline_fonts = 0
        let g:airline_left_sep = ''
        let g:airline_right_sep = ''
        " 缓冲区移动键
            nmap <silent> <leader>1         <Plug>AirlineSelectTab1
            nmap <silent> <leader>2         <Plug>AirlineSelectTab2
            nmap <silent> <leader>3         <Plug>AirlineSelectTab3
            nmap <silent> <leader>4         <Plug>AirlineSelectTab4
            nmap <silent> <leader>5         <Plug>AirlineSelectTab5
            nmap <silent> <leader>6         <Plug>AirlineSelectTab6
            nmap <silent> <leader>7         <Plug>AirlineSelectTab7
            nmap <silent> <leader>8         <Plug>AirlineSelectTab8
            nmap <silent> <leader>9         <Plug>AirlineSelectTab9
            nmap <silent> <leader>-         <Plug>AirlineSelectPrevTab
            nmap <silent> <leader>=         <Plug>AirlineSelectNextTab

    " dracula
        colorscheme dracula
        set termguicolors

        " 去除背景高亮
        highlight Normal guibg=NONE ctermbg=None
        highlight comment ctermfg=DarkGreen guifg=#008800

        " 打开行高亮, 定义行高亮样式
        set cursorline
        highlight CursorLine ctermfg=None ctermbg=236 guifg=None guibg=#111111

    " vim-illuminate
        let g:Illuminate_delay = 750
        hi illuminatedWord ctermbg=236 guibg=#555555

    " coc.nvim
        set hidden
        set updatetime=100
        set shortmess+=c
        set signcolumn=yes

        inoremap <silent><expr> <TAB>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<TAB>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        inoremap <silent><expr> <c-o> coc#refresh()

        if exists('*complete_info')
          inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
          inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif

        let g:coc_global_extensions = [
                                      \ 'coc-pairs',
                                      \ 'coc-git',
                                      \ 'coc-snippets',
                                      \ 'coc-actions',
                                      \ 'coc-json',
                                      \ 'coc-vimlsp'
                                      \]

        " 报错跳转
        nmap <silent> g[ <Plug>(coc-diagnostic-prev)
        nmap <silent> g] <Plug>(coc-diagnostic-next)

        " 定义跳转
        nmap <silent> gd <Plug>(coc-definition)
        " 查找引用
        nmap <silent> gr <Plug>(coc-references)

        " 重命名
        nmap <leader>rn <Plug>(coc-rename)

        " 格式化当前文件
        command! -nargs=0 Format :call CocAction('format')

        " 调用snippets
        imap <c-j> <plug>(coc-snippets-expand)
        " snippets的下一个参数
        let g:coc_snippet_next = '<c-j>'
        " snippets的上一个参数
        let g:coc_snippet_prev = '<c-k>'

        " 在markdown里不要自动补全`
        autocmd FileType markdown let b:coc_pairs_disabled = ['`']

    "nerdtree
        " st = 打开nerdtree
        map st :NERDTreeToggle<cr>

    "nerdtree-git-plugin
        let g:NERDTreeIndicatorMapCustom = {
            \ "Modified" : "✹",
            \ "Staged"   : "✚",
            \ "Untracked": "✭",
            \ "Renamed"  : "➜",
            \ "Unmerged" : "═",
            \ "Deleted"  : "✖",
            \ "Dirty"    : "✗",
            \ "Clean"    : "✔︎",
            \ "Unknown"  : "?"
        \ }

    "ranger
        " <leader>f = 打开ranger

    "lazygit
        let g:lazygit_floating_window_winblend = 0 " transparency of floating window
        let g:lazygit_floating_window_scaling_factor = 0.9 " scaling factor for floating window
        let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
        let g:lazygit_use_neovim_remote = 0 " fallback to 0 if neovim-remote is not installed
        " sg = 打开lazygit
        nmap <silent> sg :LazyGit<cr>

    "undotree
        " su = 打开undotree
        map su :UndotreeToggle<cr>

    "vim-signature
        " 设置mark的按键
        let g:SignatureMap = {
            \ 'Leader'             :  "m",
            \ 'PlaceNextMark'      :  "m,",
            \ 'DeleteMark'         :  "sd",
            \ 'GotoNextSpotAlpha'  :  "m<LEADER>",
            \ 'GotoNextSpotByPos'  :  "mn",
            \ 'GotoPrevSpotByPos'  :  "mp",
            \ 'ListLocalMarks'     :  "m/",
            \ }

    "nerdcommenter
        let g:NERDSpaceDelims = 1
        let g:NERDCompactSexyComs = 1
        let g:NERDDefaultAlign = 'left'
        let g:NERDAltDelims_java = 1
        let g:NERDCommentEmptyLines = 1
        let g:NERDTrimTrailingWhitespace = 1
        let g:NERDToggleCheckAllLines = 1

    "clever-f
        " 重载;和,
        map ; <Plug>(clever-f-repeat-forward)
        map , <Plug>(clever-f-repeat-back)

" 配置 coc TAB 补全行为，适配 coc 0.0.82 版本，风格类似 VScode
  inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ?
    \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'
