set clipboard=unnamedplus
set termguicolors
set mouse=a
" colorscheme desert
set nofoldenable
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set number
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set cursorline cursorcolumn
set undofile
set undodir=$HOME/.nvimundodir
" set undolevels=1000
set modeline
set modelines=5
set ignorecase
set smartcase
set showcmd
set showmatch
set lazyredraw
""""""""""""""""""""""""""""""""""""""""""""""""
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set title
" external vimrc
set exrc
set secure
"""""""""""
" for LSP
set hidden

if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" nnoremap <F12> :call LanguageClient#explainErrorAtPoint()<CR>

autocmd BufEnter * let &titlestring=fnamemodify(getcwd(), ':t') ."/" . expand("%:F")
highlight lCursor guifg=NONE guibg=Cyan

" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

set directory=$HOME/.local/share/nvim/swap/

let g:indentLine_setConceal = 0

""""""""""""""""""""""""""""""""""""""""""""""""
" map control-backspace to delete the previous word
imap <C-BS> <C-W>


""""""""""""""""""""""""""""""""""""""""""""""""
"LocationList toggle
let g:toggle_list_no_mappings = 0
noremap <script> <silent> <F1> :call ToggleLocationList()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
" Linter
" only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_virtualtext_cursor = 1
let g:ale_rust_rls_config = {
	\ 'rust': {
		\ 'all_targets': 1,
		\ 'build_on_save': 1,
		\ 'clippy_preference': 'on'
	\ }
	\ }
let g:ale_rust_rls_toolchain = ''
let g:ale_linters = {'rust': ['rls']}
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None
let g:ale_sign_error = "✖"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"

nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
"Alt-Q to quit
map <a-q> <Esc>:qa<CR>
imap <a-q> <Esc>:qa<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
"Toggle tree open/close in normal mode
map <F2> :NERDTreeToggle<CR>:call g:NERDTree.ForCurrentTab().getRoot().refresh()<CR>
"Toggle tree open/close in insert mode
imap <F2> <Esc>:NERDTreeToggle<CR><i>

""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_dotfiles = 1

""""""""""""""""""""""""""""""""""""""""""""""""
vmap <silent>t= :Tabularize /=<CR>
vmap <silent>t: :Tabularize /:<CR>
vmap <silent>t, :Tabularize /,/r<CR>
vmap <silent>t> :Tabularize /-><CR>
vmap <silent>t> :Tabularize /=><CR>

""""""""""""""""""""""""""""""""""""""""""""""""
"center line on screen
nmap <space> zz
nmap n nzz
nmap N Nzz

function! TabMove(direction)
    let s:current_tab=tabpagenr()
    let s:total_tabs = tabpagenr("$")

    " Wrap to end
    if s:current_tab == 1 && a:direction == -1
        tabmove
    " Wrap to start
    elseif s:current_tab == s:total_tabs && a:direction == 1
        tabmove 0
    " Normal move
    else
        execute (a:direction > 0 ? "+" : "-") . "tabmove"
    endif
    echo "Moved to tab " . tabpagenr() . " (previosuly " . s:current_tab . ")"
endfunction

"Move current tab to prev position
map <M-PageUp> :call TabMove(-1)<Esc>
"Move current tab to next position
map <M-PageDown> :call TabMove(1)<Esc>
"Create new tab
map <C-t> :tabnew<CR>
"Alt-left to go to the prew tab
map <M-Left> <Esc>:tabp<CR>
"Alt-right to go to the next tab
map <M-Right> <Esc>:tabn<CR>

""""""""""""""""""""""""""""""""""""""""""""""""
" let g:haddock_browser = "open"
" let g:haddock_docdir="/usr"
""""""""""""""""""""""""""""""""""""""""""""""""
"find next
map <F3> n
"find prew
map <a-F3> N
"hide current highlight
map <silent> <F4> <Esc>:noh<CR>

"Highlighting under cursor without jumping
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()

""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
" Lang support
Plug 'pearofducks/ansible-vim'
Plug 'rust-lang/rust.vim'
" Plug 'cstrahan/vim-capnp'
" Plug 'zchee/vim-flatbuffers'
" Plug 'udalov/kotlin-vim'
" Plug 'vim-erlang/vim-erlang-runtime'
" Plug 'kchmck/vim-coffee-script'
" Plug 'raichoo/purescript-vim'
" Plug 'ElmCast/elm-vim'
" Plug 'lukerandall/haskellmode-vim'

" Editor enhancements
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'andymass/vim-matchup'
Plug 'terryma/vim-multiple-cursors'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'

" Completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'vim-scripts/gitignore'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'eparreno/vim-l9'
" Plug 'cfurrow/vim-fuzzyfinder'

" Vim enhancements
Plug 'milkypostman/vim-togglelist'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug '~/projects/my/nvim/mydesert/'
Plug '~/.local/share/nvim/plugged/runtime/'
" Plug 'honza/vim-snippets'
" Plug 'garbas/vim-snipmate'

" Plug 'tomtom/tlib_vim'
" Plug 'ludovicchabant/vim-gutentags'
" Plug 'xolox/vim-misc'
" Plug '~/projects/my/nvim/nginx/'
" Plug 'othree/vim-autocomplpop'
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" Plug 'racer-rust/vim-racer'
" Plug 'vim-erlang/vim-erlang-omnicomplete'
" Plug 'vim-syntastic/syntastic'
" Plug 'HHammond/vim-easytags'
" Plug 'Valloric/YouCompleteMe'
call plug#end()

colorscheme mydesert
