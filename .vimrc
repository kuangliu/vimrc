"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                                                              "
"                       __   _ _ _ __ ___  _ __ ___                            "
"                       \ \ / / | '_ ` _ \| '__/ __|                           "
"                        \ V /| | | | | | | | | (__                            "
"                         \_/ |_|_| |_| |_|_|  \___|                           "
"                                                                              "
"                                                                              "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

let $vimhome=fnamemodify(resolve(expand("~/.vimrc")), ':p:h')

" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" Be iMproved
set nocompatible

"=====================================================
"" PlugInstall settings
"=====================================================
call plug#begin('~/.vim/plugged')
    "-------------------=== Code/Project navigation ===-------------
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'easymotion/vim-easymotion'
    Plug 'rhysd/accelerated-jk'
    Plug 'schickling/vim-bufonly'
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'unblevable/quick-scope'
    Plug 'romainl/vim-cool'                   " Clear search highlight 
    Plug 'voldikss/vim-floaterm'

    "-------------------=== Other ===-------------------------------
    Plug 'bling/vim-airline'                  " Lean & mean status/tabline for vim
    Plug 'vim-airline/vim-airline-themes'     " Themes for airline
    Plug 'Lokaltog/powerline'                 " {'rtp': 'powerline/bindings/vim/'}   Powerline fonts plugin
    Plug 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
    Plug 'joshdick/onedark.vim'

    "-------------------=== Snippets support ===--------------------
    Plug 'MarcWeber/vim-addon-mw-utils'       " dependencies #1
    Plug 'tomtom/tlib_vim'                    " dependencies #2
    Plug 'honza/vim-snippets'                 " snippets repo

    "-------------------=== Coc support ===-------------------
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    "-------------------=== Languages support ===-------------------
    Plug 'tpope/vim-commentary'               " Comment stuff out
    Plug 'Rykka/riv.vim'                      " ReStructuredText plugin
    Plug 'preservim/nerdcommenter'
    Plug 'terryma/vim-multiple-cursors'

    "-------------------=== Python  ===-----------------------------
    " Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    " Plug 'scrooloose/syntastic'               " Syntax checking plugin for Vim

    "-------------------=== Code Format ===------------------------
    Plug 'google/vim-maktaba'
    Plug 'google/vim-codefmt'
    " Also add Glaive, which is used to configure codefmt's maktaba flags. See
    " " `:help :Glaive` for usage.
    Plug 'google/vim-glaive'

    Plug 'mhinz/vim-startify'
    Plug 'tpope/vim-eunuch'
call plug#end()
call glaive#Install()

" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]
Glaive codefmt clang_format_style='Chromium'
" Glaive codefmt clang_format_style=file
" Glaive codefmt clang_format_style='Google'

filetype on
filetype plugin on
filetype plugin indent on

"=====================================================
"" General settings
"=====================================================
syntax enable                               " syntax highlight

set t_Co=256                                " set 256 colors
" colorscheme wombat256mod                    " set color scheme

set number                                  " show line numbers
set ruler
set ttyfast                                 " terminal acceleration

set tabstop=2                               " 4 whitespaces for tabs visual presentation
set shiftwidth=2                            " shift lines by 4 spaces
set smarttab                                " set tabs for a shifttabs logic
set expandtab                               " expand tabs into spaces
set autoindent                              " indent when moving to the next line while writing code

set cursorline                              " shows line under the cursor's line
set showmatch                               " shows matching part of bracket pairs (), [], {}

set enc=utf-8	                            " utf-8 by default

set nobackup 	                            " no backup files
set nowritebackup                           " only in case you don't want a backup file while editing
set noswapfile 	                            " no swap files

set backspace=indent,eol,start              " backspace removes all (indents, EOLs, start) What is start?

set scrolloff=10                            " let 10 lines before/after cursor during scroll

"set clipboard=unnamed                       " use system clipboard
set clipboard+=unnamedplus

set exrc                                    " enable usage of additional .vimrc files from working directory
set secure                                  " prohibit .vimrc files to execute shell, create files, etc...

syntax enable
set t_Co=256

" map ctrl-s to save
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>a

colorscheme onedark
set background=dark
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" Move current line up and down
nmap <c-k> :move -2<cr>  " move up
nmap <c-j> :move +1<cr>  " move down

" Set leaderkey to space
let mapleader=" "

" Run current python file
nmap <F5> :!python % <CR>

" Additional mappings for Esc (useful for MacBook with touch bar)
"inoremap jj <Esc>
"inoremap jk <Esc>

"=====================================================
"" Accelerated-jk settings
"=====================================================
nmap <silent> j <Plug>(accelerated_jk_gj)
nmap <silent> k <Plug>(accelerated_jk_gk)

"=====================================================
"" FZF settings
"=====================================================
" nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <c-p> :Files<CR>
nnoremap <Leader>rg :Rg<CR>

"=====================================================
"" Easymotion settings
"=====================================================
nmap s <Plug>(easymotion-s2)

"=====================================================
"" QuickScope settings
"=====================================================
" Trigger a highlight only when pressing f and F.
let g:qs_highlight_on_keys = ['f', 'F']

"=====================================================
"" NeoVim terminal settings
"=====================================================
tnoremap <Esc><Esc> <C-\><C-n>     " leave nvim terminal mode

nmap <silent> <Leader>h :wincmd h<CR>
nmap <silent> <Leader>j :wincmd j<CR>
nmap <silent> <Leader>k :wincmd k<CR>
nmap <silent> <Leader>l :wincmd l<CR>

nmap <Leader>q :q!<CR>
vmap <Leader>y "+y

" Replace the word under cursor.
nnoremap <Leader>r :%s/\<<c-r><c-w>\>//g<left><left>

" 切换 buffer
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>
nnoremap <Leader>bw :<c-u>bp <bar> bd #<CR>    " quit current buffer
nnoremap <Leader>bo :Bonly<CR>                 " only contain current buffer

"=====================================================
"" Coc settings
"=====================================================
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"=====================================================
"" Tabs / Buffers settings
"=====================================================
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>

"=====================================================
"" Search settings
"=====================================================
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results
set ignorecase
set smartcase

" set nofoldenable                                                " disable folding
set foldenable
set foldmethod=indent
set foldlevelstart=99                                             " do not fold on launch
set confirm                                                       " prompt when existing from an unsaved file
set backspace=indent,eol,start                                    " More powerful backspacing
set title                                                         " show file in titlebar
set laststatus=2                                                  " use 2 lines for the status bar
set matchtime=2                                                   " show matching bracket for 0.2 seconds

set guifont=SF\ Mono\ Regular:h18

"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='onedark'
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

" 关闭状态显示空白符号计数
" let g:airline#extensions#whitespace#enabled = 1
" let g:airline#extensions#whitespace#symbol = '!'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = ''
let g:airline_symbols.paste = ''
let g:airline_symbols.spell = ''
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

"=====================================================
"" coc-explorer settings
"=====================================================
" 打开vim时如果没有文件自动打开explorer
autocmd VimEnter * if !argc() | call execute('CocCommand explorer') | endif  " Load file explorer only if vim is run without arguments
autocmd VimEnter * wincmd p
"当explorer为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
nmap <silent> <Leader>f :CocCommand explorer<CR>  " File explorer

"=====================================================
"" NERDCommenter settings
"=====================================================
" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_python = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" Multi Cursor
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"=====================================================
"" Floaterm settings
"=====================================================
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1

nnoremap <silent> <Leader>tr :FloatermNew --position=right --height=1 --width=0.4 --wintype=normal<CR>
nnoremap <silent> <Leader>tb :FloatermNew --position=bottom --height=0.4 --width=1 --wintype=normal<CR>
nnoremap <silent> <Leader>tt :FloatermToggle<CR>

"=====================================================
"" General settings
"=====================================================
" Git Fugitive
autocmd QuickFixCmdPost *grep* cwindow

nmap gs :G<CR>
nmap gc :Gcommit<CR>

" Google FMT
augroup autoformat_settings
    " autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
    " autocmd FileType dart AutoFormatBuffer dartfmt
    " autocmd FileType go AutoFormatBuffer gofmt
    " autocmd FileType gn AutoFormatBuffer gn
    " autocmd FileType html,css,json AutoFormatBuffer js-beautify
    " autocmd FileType java AutoFormatBuffer google-java-format
    " autocmd FileType python AutoFormatBuffer yapf
    autocmd FileType python AutoFormatBuffer autopep8
    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

" Remember position of last edit and return on reopen
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

