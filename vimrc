set nocompatible
runtime! macros/matchit.vim
filetype plugin indent on
syntax enable

" ************************************************
" PLUGINS
" ************************************************
call plug#begin('~/.vim/plugged')

" Editor
Plug 'dense-analysis/ale'
Plug 'craigemery/vim-autotag'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'ervandew/supertab'
" IMPORTANT: Requires https://github.com/ggreer/the_silver_searcher
Plug 'mileszs/ack.vim'
Plug 'mkitt/pigment', { 'tag': 'v1.0.0' }
Plug 'nelstrom/vim-visual-star-search'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
" Plug 'ton/vim-bufsurf'
Plug 'vim-scripts/YankRing.vim'
Plug 'yssl/QFEnter'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Filetypes
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'quramy/tsuquyomi'


call plug#end()

" ************************************************
" PREFERENCES
" ************************************************
set autoindent
set autoread
set backspace=2
set clipboard=unnamed
set complete-=i
set completeopt=longest,menu,menuone,preview,noselect,noinsert
set display+=lastline
set expandtab
set formatoptions+=j
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:▸\ ,eol:¬,trail:·
set mouse=a
set nobackup
set nojoinspaces
set noshowcmd
set nostartofline
set noswapfile
set nowrap
set nowritebackup
set nrformats-=octal
set number
set ruler
set scrolloff=3
set sessionoptions-=options
set shiftround
set shiftwidth=2
set shortmess+=S
set showmatch
set sidescrolloff=3
set smartcase
set smartindent
set smarttab
set softtabstop=2
set splitright splitbelow
set tabstop=2
set title
set ttimeout
set ttimeoutlen=50
set ttyfast
set undolevels=1000
set updatetime=100
set wildignore+=*.DS_Store
set wildmenu
set wildmode=longest:full,full

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
" else
  " set signcolumn=yes
" endif

if has("balloon_eval") && has("unix")
  set ballooneval
endif

if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

" The Silver Searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

let g:ctrlp_extensions=['line']
let g:ctrlp_cache_dir=$HOME.'/.vim/tmp/ctrlp/'
let g:ctrlp_custom_ignore='vendor/bundle\|.bundle\|tmp\|.git$'

let g:ctrlsf_auto_close=0

let g:ale_fix_on_save=1
let g:ale_fixers={'javascript': ['eslint'], 'terraform': ['terraform'], 'ruby': ['standardrb']}
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_linters = {'go': ['gofmt', 'govet', 'gotype', 'gopls']}
let g:ale_history_log_output=0
let g:ale_javascript_eslint_executable='eslint_d'
let g:ale_javascript_eslint_use_global=1
let g:ale_open_list='on_save'
let g:ale_sign_error='☠️'
let g:ale_sign_warning='⚠️'

let g:netrw_liststyle=3
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMapUpdir='-'
let g:NERDTreeMinimalUI=1
let g:NERDTreeWinSize=40

let g:SuperTabLongestEnhanced=1
let g:SuperTabLongestHighlight=1

let g:qfenter_keymap={}
let g:qfenter_keymap.vopen=['<C-v>']
let g:qfenter_keymap.hopen=['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen=['<C-t>']

let g:yankring_window_height=10
let g:yankring_history_dir=$HOME.'/.vim/tmp/yankring/'

let g:javascript_plugin_flow=1

" Enable Go syntax highlighting
let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_operators= 1
let g:go_highlight_extra_types=1
" let g:go_auto_type_info = 1

" ************************************************
" MAPPINGS
" ************************************************
" Move between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" For my convenience
noremap <C-b> ^
noremap <C-e> $
noremap <C-m> :vsplit<CR>

" NERDTree in a buffer (like netrw)
nnoremap <silent>- :silent edit %:p:h<CR>
nnoremap <silent>_ :silent edit .<CR>

" Override jumplist commands
" nnoremap <silent><C-i> :BufSurfBack<CR>
" nnoremap <silent><C-o> :BufSurfForward<CR>

" Another alternative CtrlP mapping
nnoremap <silent><C-@> :CtrlP<CR>

" The `g` commands
" :nnoremap gD :vert winc ]<CR>
nnoremap <silent>gD <C-w><C-]>
nnoremap <silent>gl :CtrlP<CR>
nnoremap <silent>gL :CtrlPBuffer<CR>
nnoremap <silent>gy :NERDTreeToggle<CR>
" Use .ignore for ignoring directories when searching
nnoremap gs :Ack!<space>
nmap gz <Plug>CtrlSFPrompt
vmap gz <Plug>CtrlSFVwordExec
nnoremap <silent>gV `[v`]

" Clear the search highlight
noremap <silent><leader>\ :nohlsearch<CR>

" Yank/paste contents using an unnamed register
xnoremap <silent><leader>y "xy
noremap <silent><leader>p "xp

" ************************************************
" AUTO COMMANDS
" ************************************************
func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

if has("autocmd")
  augroup FTOptions
    autocmd!
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile *.ts set filetype=javascript
    autocmd BufRead,BufNewFile *.tsx set filetype=typescript.tsx
    autocmd BufRead,BufNewFile *.tsx set syntax=javascript.jsx
    autocmd BufRead,BufNewFile .env.* set filetype=sh
    autocmd BufRead,BufNewFile COMMIT_EDITMSG setlocal spell
    autocmd FileType markdown,text,txt setlocal textwidth=80 linebreak nolist wrap spell
    autocmd QuickFixCmdPost *grep* botright copen
    autocmd QuitPre * if empty(&buftype) | lclose | endif
    autocmd FileType javascript nnoremap <buffer> gd :TsuDefinition<CR>
    autocmd FileType typescript.tsx nnoremap <buffer> gd :TsuDefinition<CR>
    autocmd FileType javascript iabbrev <buffer> cdl console.log()<Left><C-R>=Eatchar('\s')<CR>
  augroup END
endif

" ************************************************
" THEME
" ************************************************
colorscheme pigment
