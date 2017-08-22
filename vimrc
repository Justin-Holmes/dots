" Disable vi compatibility
set nocompatible

" Plugins
" --------------------------------------
call plug#begin('~/.vim/plugged')

" Editor
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'scrooloose/nerdtree'
Plug 'mkitt/pigment'
Plug 'yssl/QFEnter'
Plug 'ervandew/supertab'
Plug 'vim-syntastic/syntastic'
Plug 'mkitt/tabline.vim'
Plug 'ton/vim-bufsurf'
Plug 'mhinz/vim-grepper'
Plug 'henrik/vim-indexed-search'
Plug 'terryma/vim-multiple-cursors'
Plug 'nelstrom/vim-visual-star-search'
Plug 'vim-scripts/YankRing.vim'

" Editing
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Filetypes
Plug 'othree/html5.vim'
Plug 'keith/swift.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'alampros/vim-styled-jsx'
Plug 'tpope/vim-rails'

" Utility
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'


call plug#end()

runtime! macros/matchit.vim
filetype plugin indent on
syntax enable

" Preferences
" --------------------------------------
set autoindent
set autoread
set autowrite
set backspace=2
set clipboard=unnamed
set complete-=i
set completeopt=longest,menu
set directory=~/.vim/tmp/swap/
set display+=lastline
set expandtab
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
set nowrap
set nrformats-=octal
set number
set ruler
set scrolloff=3
set sessionoptions-=options
set shiftround
set shiftwidth=2
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
set wildignore+=*.DS_Store
set wildmenu
set wildmode=longest:full,full

if has("balloon_eval") && has("unix")
  set ballooneval
endif

if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

if executable('rg')
  set grepprg=rg\
  let g:ctrlp_user_command='rg --files %s'
  let g:ctrlp_use_caching=0
endif

let g:ctrlp_by_filename=1
let g:ctrlp_extensions=['line']
let g:ctrlp_cache_dir=$HOME.'/.vim/tmp/ctrlp/'
let g:ctrlp_custom_ignore='vendor/bundle\|.bundle\|tmp\|.git$'
let g:ctrlp_map='<F1>'

let g:ctrlsf_auto_close=0

let g:netrw_liststyle=3

let g:NERDTreeWinSize=40
let g:NERDTreeMinimalUI=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMapUpdir='-'

let g:SuperTabLongestEnhanced=1
let g:SuperTabLongestHighlight=1

" Open quick fix and location window items with CtrlP commands
let g:qfenter_enable_autoquickfix=0
let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors=1
let g:syntastic_always_populate_loc_list=1

let g:syntastic_javascript_checkers=['eslint', 'flow']
let g:syntastic_javascript_eslint_args="--rule 'no-console: 0'"
if executable('eslint_d') && executable('node_modules/.bin/eslint')
  let g:syntastic_javascript_eslint_exec='eslint_d'
endif

if executable('node_modules/.bin/flow')
  let g:syntastic_javascript_flow_exec='node_modules/.bin/flow'
  let g:syntastic_javascript_flow_exe='node_modules/.bin/flow --show-all-errors --json --quiet'
endif

let g:yankring_window_height=10
let g:yankring_history_dir=$HOME.'/.vim/tmp/yankring/'

let g:indexed_search_show_index_mappings=0
let g:indexed_search_colors=0

let g:javascript_enable_domhtmlcss=1
let g:javascript_plugin_flow=1
let g:jsx_ext_required=0

" Mappings
" --------------------------------------
" RSI reduction
nnoremap j gj
nnoremap k gk

" Move between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" NERDTree in a buffer (like netrw)
nnoremap <silent>- :silent edit %:p:h<CR>
nnoremap <silent>_ :silent edit .<CR>

" Override jumplist commands
nnoremap <silent><C-i> :BufSurfBack<CR>
nnoremap <silent><C-o> :BufSurfForward<CR>

" Another alternative CtrlP mapping
nnoremap <silent><C-@> :CtrlP<CR>

" The `g` commands
nnoremap <silent>gF :vertical wincmd f<CR>
nnoremap <silent>gl :CtrlP<CR>
nnoremap <silent>gL :CtrlPBuffer<CR>
nnoremap <silent>gy :NERDTreeToggle<CR>
nnoremap gs :GrepperRg<space>
xnoremap gs y:<c-u>GrepperRg -F <C-R>=shellescape(expand(@"),1)<CR>
nmap gz <Plug>CtrlSFPrompt
vmap gz <Plug>CtrlSFVwordExec

" Visually select the text that was last edited/pasted
nnoremap <silent>gV `[v`]

" Clear the search highlight
noremap <silent><leader>\ :nohlsearch<CR>

" Remove whitespace
noremap <silent><leader>CW :%s/\s\+$//<CR>

" Yank/paste contents using an unnamed register
xnoremap <silent><leader>y "xy
noremap <silent><leader>p "xp

" Filetypes
" --------------------------------------
func! Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc

if has("autocmd")
  augroup FTOptions
    autocmd!
    autocmd User Grepper :resize 10
    autocmd QuickFixCmdPost *grep* botright copen
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    autocmd FileType markdown,text,txt setlocal tw=80 linebreak nolist wrap spell
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
    autocmd BufRead,BufNewFile .{babel,eslint}rc set filetype=json
    autocmd BufRead,BufNewFile *.{flow} set filetype=javascript
    " Abbreviations
    autocmd FileType javascript iabbrev <buffer> bgc backgroundColor: '',<Left><Left><C-R>=Eatchar('\s')<CR>
    autocmd FileType javascript iabbrev <buffer> sdb outline: '1px dotted blue',<C-R>=Eatchar('\s')<CR>
    autocmd FileType javascript iabbrev <buffer> cdl console.log()<Left><C-R>=Eatchar('\s')<CR>
  augroup END
endif

" Theme
" --------------------------------------
colorscheme pigment
