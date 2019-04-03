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
" for racer
" set hidden
" let g:racer_cmd = "/home/user/.cargo/bin/racer"
" let g:racer_experimental_completer = 1
" let g:racer_insert_paren = 1
"""""""""""
" for LSP
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <F12> :call LanguageClient#explainErrorAtPoint()<CR>
" Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"""""""""""
autocmd BufEnter * let &titlestring=fnamemodify(getcwd(), ':t') ."/" . expand("%:F")
highlight lCursor guifg=NONE guibg=Cyan
""""""""""""""""""""""""""""""""""""""""""""""""
" let g:easytags_file = './tags'
" set tags=./tags
" let g:easytags_dynamic_files = 2
" let g:easytags_events = ['BufWritePost', 'BufReadPost']
" let g:easytags_syntax_keyword = 'always'
let tern#is_show_argument_hints_enabled = 0
set completeopt-=preview "shut that fucking window up!

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
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_check_on_open=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_mode_map = { 'passive_filetypes': ['yaml'] }
"let g:syntastic_auto_loc_list=1
"let g:syntastic_quiet_warnings=1

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
"Ctrl-O to open FuzzyFinder
map <C-o> <Esc>:FufRenewCache<CR><Esc>:FufFile<CR>


""""""""""""""""""""""""""""""""""""""""""""""""
vmap <silent>t= :Tabularize /=<CR>
vmap <silent>t: :Tabularize /:<CR>
vmap <silent>t, :Tabularize /,/r<CR>
vmap <silent>t> :Tabularize /-><CR>
vmap <silent>t> :Tabularize /=><CR>


""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_char = '┆'

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
let g:haddock_browser = "open"
let g:haddock_docdir="/usr"
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

" let g:syntastic_erlc_include_path = 'ebin'
let g:syntastic_erlang_checkers=['syntaxerl']

""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.local/share/nvim/plugged')
Plug 'pearofducks/ansible-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'vim-syntastic/syntastic'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'lukerandall/haskellmode-vim'
" Plug 'HHammond/vim-easytags'
" Plug 'Valloric/YouCompleteMe'
Plug 'ludovicchabant/vim-gutentags'
Plug 'xolox/vim-misc'
Plug 'cfurrow/vim-fuzzyfinder'
Plug 'eparreno/vim-l9'
Plug 'Yggdroot/indentLine'
Plug '~/projects/my/nvim/nginx/'
Plug '~/projects/my/nvim/mydesert/'
Plug 'scrooloose/nerdtree'
Plug 'milkypostman/vim-togglelist'
Plug 'vim-airline/vim-airline'
Plug 'ElmCast/elm-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'raichoo/purescript-vim'
Plug 'honza/vim-snippets'
Plug 'othree/vim-autocomplpop'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'udalov/kotlin-vim'
Plug 'rust-lang/rust.vim'
Plug '~/.local/share/nvim/plugged/runtime/'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
" Plug 'racer-rust/vim-racer'
" Plug 'vim-erlang/vim-erlang-omnicomplete'
call plug#end()

colorscheme mydesert
