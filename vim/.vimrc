" Pulgin's  ====================================================================

set nocompatible
filetype plugin on
" gruvbox error fix, for getting spell check hightlitghting to work again
let g:gruvbox_guisp_fallback = "bg"
syntax on			" turn on syntax highlighting
syntax enable

" vim-plug auto-intsall
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugins')

Plug 'vimwiki/vimwiki', { 'branch' : 'dev'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() },
      \ 'for': ['markdown', 'vim-plug']}

Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'

Plug 'ycm-core/YouCompleteMe' 

Plug 'vim-syntastic/syntastic'
Plug 'morhetz/gruvbox'

"Zettlekasten
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive' 

Plug 'jiangmiao/auto-pairs'

Plug 'vlime/vlime', {'rtp': 'vim/'}

Plug 'sillybun/vim-repl'
    
call plug#end()

" Settings ==================================================================

set hidden			" allows reuse the same window
set encoding=utf-8		" set encoding
set autoindent
set shiftwidth=4		" Number of autoindent spaces
au FileType markdown set shiftwidth=2
au FileType vimwiki set shiftwidth=2
set smartindent
set smarttab
set breakindent			" indent line wraps
set scrolloff=2                 " always show at least one line abo/below cursor

set rnu				" set relative line number
set nu
set ruler			" Show row and column info
set autoread			" auto read files changed outside vim	
set clipboard=unnamedplus	" use the system clipboard paste into vim
set colorcolumn=81		" highlight max column length
au BufRead *.lsp, set colorcolumn=0

set expandtab			" tabs to spaces
set hlsearch			" highlight search query
set incsearch			" highlight when typing
set ignorecase			" case insensitive searching
set smartcase			" only use case sensitive search when uppercase
set linebreak			" break on word boundaries

set noswapfile			" no swap files
set showmatch			" show matching brackets
set history=1000
set undolevels=1000
set visualbell			
set noerrorbells		" turns of the beep
set backspace=indent,eol,start	" allows backspace over autoindent etc
set ttyfast                     " speeds up scrolling

set updatetime=100              " default 4000 ms = 4 s, is noticeable
set cursorline                  " highlights the cursorline
set t_Co=256			" for the colorschemes
set wildmenu
set mouse=a                     " Enable mouse for scrolling and resizing

set confirm                     " Confirm when closing an unsaved file

" Python PEP indentation 
au  FileType python call PythonVimSettings()

" removes white space at boot, for c and python files
au FileType python,c au BufWritePre <buffer> %s/\s\+$//e

" Functions =================================================================
function! PythonVimSettings()
    set tabstop=4
    set shiftwidth=4
    set textwidth=79
    set colorcolumn=79
    set autoindent
    let python_highlight_all=1
    let g:repl_position = 3 " 0=bottom, 1 =op, 2=left, 3=right
    nnoremap <F9> :w <CR> :! python3 %  <CR>
    nnoremap <F3> :w <CR> :! pytest -vv ./tests/test_%  <CR>
    nnoremap <Leader>r :REPLToggle<CR>      
endfunction

function! NetrwMapping()
    nmap <buffer> H u                           
    nmap <buffer> h -^                          
    nmap <buffer> l <CR>                        

    nmap <buffer> . gh                          
    nmap <buffer> P <C-w>z                      

    nmap <buffer> L <CR>:Lexplore<CR>           
    nmap <buffer> <Leader>e :Lexplore<CR>      
endfunction


" Theme  ====================================================================
"colors zenburn
colors gruvbox
set background=dark

" Keybindings ===============================================================

let mapleader = ","
" Move lines
nnoremap <M-Down> :m .+1<CR>==
nnoremap <M-Up> :m .-2<CR>==
vnoremap <M-Down> :m '>+1<CR>gv=gv
vnoremap <M-Up> :m '<-2<CR>gv=gv

set pastetoggle=<F2>		" toggle between 'paste' and 'nopaste'
nnoremap <F5> :w<CR>
nmap <F8> : pandoc % -o %<.pdf<CR>
au FileType c map <F9> :! ./%<  <CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
nmap Y y$                        " acts like 'D' and 'C' instead of 'yy'

source ~/dotfiles/vim/vcomments.vim
map <Leader>c :call Comment()<CR>
map <Leader>C :call Uncomment()<CR>

" ** ctags **
set tags+=./tags;,tags
" Generates ctags silently
nnoremap <Leader>tt :silent !ctags -R $NOTES_DIR <CR>:redraw!<CR>
" Go to index of notes and set working directory to my notes
nnoremap <leader>ni :e $NOTES_DIR/index.md<CR>:cd $NOTES_DIR<CR>

" *** Spell Checking ***
" zg = 'adds the selected word to the dictionary' , zw = 'marks words as incorrect'
" Toggle SpellCheck
nnoremap <Leader>sc :setlocal spell!<CR>
nnoremap <C-n> ]s
nnoremap <C-p> [s
" set local language
nnoremap <Leader>ss :setlocal spell! spelllang=sv<CR>
nnoremap <Leader>se :setlocal spell! spelllang=en<CR>
nnoremap <Leader>sb :setlocal spell! spelllang=en,sv<CR>
inoremap <C-l> <C-g>u<Esc>[s1z=`]a<C-g>u

" FileExplorer Settings (netrw) ================================
let g:netrw_winsize = 30
let g:netrw_banner = 0
let g:netrw_keepdir = 0 
let g:netrw_liststyle = 1" or 3
let g:netrw_sort_options = 'i'
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

nmap <Leader>e :Lexplore %:p:h<CR>

augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

" VimWiki ===================================================================
let my_wiki = {}
let my_wiki.path = $NOTES_DIR             "'~/Documents/notes/' 
let my_wiki.syntax = 'markdown'
let my_wiki.ext = '.md'
let my_wiki.automatic_nested_syntaxes = 1

let my_zettelkasten = {}
let my_zettelkasten.path = $NOTES_DIR . '/zettelkasten/'
let my_zettelkasten.syntax = 'markdown'
let my_zettelkasten.ext = '.md'
let my_zettelkasten.automatic_nested_syntaxes = 1
let my_zettelkasten.auto_tags = 1
let my_zettelkasten.auto_toc = 1

let exjobb = {}
let exjobb.path = '~/ExtraSpace/study/DVGC25/repository/BSc-project/alex-notes/theory/'
let exjobb.syntax = 'markdown'
let exjobb.ext = '.md'
let exjobb.automatic_nested_syntaxes = 1
let exjobb.auto_tags = 1
let exjobb.auto_toc = 1

let g:vimwiki_list = [ my_wiki, my_zettelkasten, exjobb]

nnoremap <Leader><Space> :VimwikiToggleListItem<CR>
" Transform to html keyBindings
nmap <silent> <leader>wb :Vimwiki2HTMLBrowse<CR>
au FileType markdown nnoremap <Leader>n gg5dd6j

" *** Zettlekasten ***
let g:nv_search_paths = [ $NOTES_DIR . '/zettelkasten/']
let g:nv_default_extension = '.md'
let g:zettel_format = "%title-%d%m%y-%H%M"
let g:zettel_date_format = '%d-%m/%Y'
let g:zettel_link_format = "[%title](%link)"
let g:zettel_backlinks_title = "Backlinks"

let g:vimwiki_markdown_link_ext = 1
let g:zettel_options = [{ "template" : "~/dotfiles/vim/zettel/zettel_template.tpl" }, 
            \ { "template" : "~/dotfiles/vim/zettel/zettel_template.tpl" },
            \ { "template" : "~/dotfiles/vim/zettel/zettel_template.tpl" }]


set laststatus=2

" Markdown-Preview =========================================================
let g:mkdp_browser = 'firefox'
let g:mkdp_auto_close = 0
let g:mkdp_preview_options = {
  \ 'katex': {},
  \ }

nmap <leader>p <Plug>MarkdownPreview

" YouCompleteMe  ============================================================
let g:ycm_show_diagnostics_ui = 0       " Lets syntastic checkers run with YCM
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_enable_diagnostic_signs = 1           " Enable line highligting diagnostics
let g:ycm_enable_diagnostic_highlighting = 1    " Highlight regions of diagnostic text
let g:ycm_echo_current_diagnostic = 1           " Echo line's diagnostic that cursor is on
"let g:ycm_filetype_blacklist = {
"                                \ 'tagbar': 1,
"                                \ 'notes': 1,
"                                \ 'markdown': 1,
"                                \ 'netrw': 1,
"                                \ 'text': 1,
"                                \ 'vimwiki': 1,
"                                \}

" UltiSnips =================================================================
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsListSnippets = '<c-tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = '~/dotfiles/vim/UltiSnips/'
let g:UltiSnipsSnippetDirectories=['~/dotfiles/vim/UltiSnips/']

" Syntastic ================================================================
let g:syntastic_shell = "/bin/sh"
 if globpath(&runtimepath, 'plugin/airline.vim', 1) ==# '' && globpath(&runtimepath, 'plugin/lightline.vim', 1) ==# '' 
   set statusline+=%#warningmsg# 
   set statusline+=%{SyntasticStatuslineFlag()} 
   set statusline+=%* 
 endif 
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


let g:syntastic_python_checkers=["flake8"]
let g:syntastic_python_flake8_args="--ignore=E501,W601"

au FileType tex let g:syntastic_auto_loc_list = 0
au FileType tex let g:syntastic_check_on_open  = 0
nmap <leader>l :lclose<cr>
nmap <leader>o :lopen<cr>
nmap <leader>n :lnext<cr>

" Powerline =================================================================
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup


" VimTex (latex plugin)======================================================
"let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
set conceallevel=1

let g:tex_conceal='abdmg'

au FileType tex nnoremap <silent> <F9> :w <CR> :! pdflatex %  <CR>

let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode=0

" Auto-pairs ================================================================
au FileType lisp let b:AutoPairs = AutoPairsDefine({}, ["'"])

" Alacritty mouse fix =======================================================
set ttymouse=sgr

