" config based on: https://github.com/amix/vimrc/tree/master/vimrcs

" vim-plug: bootstrap
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug: begin
call plug#begin('~/.vim/plugged')

    " visuals
    Plug 'vim-scripts/peaksea'
    Plug 'itchyny/lightline.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'nathanaelkane/vim-indent-guides'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'

    " ide
    Plug 'tpope/vim-commentary'
    Plug 'dense-analysis/ale'
    if has('nvim')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif
call plug#end()

" colors: setup
if empty($TMUX)
    if has("nvim")
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if has("termguicolors")
        set termguicolors
    endif
endif

syntax on
colorscheme peaksea

set spell
" peaksea: spellcheck
hi SpellBad    cterm=undercurl    ctermbg=NONE    ctermfg=209
hi SpellCap    cterm=undercurl    ctermbg=NONE    ctermfg=69
hi SpellRare   cterm=undercurl    ctermbg=NONE    ctermfg=219
hi SpellLocal  cterm=undercurl    ctermbg=NONE    ctermfg=153

source ~/.vim/config-lightline.vim

" linter highlights
let g:ale_set_highlights = 1

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

" indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_tab_guides = 0

let g:go_version_warning = 0

" search
set ignorecase
set smartcase
set hlsearch   " highlight
set incsearch  " instant highlight

" leader key
let mapleader=","

" x to black hole
noremap x "_x

" clear highlight
map <silent> <leader><cr> :noh<cr>

" persistent undo
set undofile

" show keystroke
set showcmd

" mode displayed in status line
set noshowmode

" yank to/from keyboard, requires `xclip`
set clipboard=unnamedplus

" " remove faulty margin
" set foldcolumn=0

" tab guides
set list listchars=tab:\»\ ,eol:↴ ",space:⋅
set tabstop=4

" mouse
set mouse=a
set mousemodel=extend
nmap <ScrollWheelUp> 2<Up>
nmap <ScrollWheelDown> 2<Down>

" scroll past end
"set scrolloff=999
nnoremap <silent> <expr> <Down> line('.') == line('$') ? "<C-E>" : "<Down>"
inoremap <silent> <expr> <Down> line('.') == line('$') ? "<C-X><C-E>" : "<Down>"

" colors: background off & more
hi Normal ctermbg=NONE guibg=NONE
hi NonText ctermbg=NONE guibg=NONE
hi EndOfBuffer ctermfg=yellow guifg=#D19A66
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgrey guibg=#3E4452
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey guibg=#3E4452

" " at last: draw everything then be lazy
" " simple `redraw` does not work well with `noshowmode`
" autocmd VimEnter * redraw!

" vim: tabstop=4 softtabstop=4 shiftwidth=4 expandtab
