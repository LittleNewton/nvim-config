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
    " 重载操作
        map <c-s>                           <nop>
        map <c-q>                           <nop>
        " Ctrl+S：保存
        nmap <c-s>                          :w<cr>
        " Ctrl+Q：退出
        nmap <c-q>                          :q<cr>
        " F5：丢失更改重新读取
        nnoremap <F5>                       :e!<cr>

    " Leader键设置为空格键
        let mapleader=' '
        nmap <leader>                       <nop>

    " s键作为二级按键
        nmap s                              <nop>
        " sn = 取消高亮
        nnoremap <silent> sn                :nohl<cr>


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
call plug#begin('~/.config/nvim/plugged')
    " 外观
    Plug 'vim-airline/vim-airline'
    Plug 'dracula/vim'

    " coc补全框架
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

        " 打开行高亮, 定义行高亮样式
        set cursorline
        highlight CursorLine ctermfg=None ctermbg=236 guifg=None guibg=#111111

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
                                      \]
