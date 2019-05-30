" TODO:
" 1. Nvim-R plugin settings and usage.
" 2. ale plugin settings.
" 3. deal with the quickly disappearing welcome screen and create a nice one.
" 4. deal with indentation problem in vimtex.
" 5. deal with folds sometimes closing on write.
" 6. environments from vimtex to markdown - dae, da$, die etc.
" 7. open documentation/help pages with line numbers.
" 8. repair filetype based plugin loading - reduces the risk of collisions.

" << LOAD PLUGINS >> ---------------------------------------------------------


call plug#begin('~/.local/share/nvim/plugged')

" general plugins 
Plug 'junegunn/fzf' " easy use of fuzzy finder from vim
Plug 'junegunn/fzf.vim' " easy use of fuzzy finder from vim
Plug 'Konfekt/FastFold' " speed up folding in vim
Plug 'matze/vim-move' " moving highlighted text by small distances easily
Plug 'mbbill/undotree' " visualization of full history of modifications
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " file system explorer
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'terryma/vim-smooth-scroll' " smooth scrolling (better than <C-b> and <C-f>)
Plug 'tpope/vim-commentary' " easy commenting out with 'gc'
Plug 'tpope/vim-surround' " manipulating surrounding tags 
Plug 'vim-airline/vim-airline' " status line at the bottom of each window
Plug 'vim-airline/vim-airline-themes' " themes for the above status line
Plug 'ludovicchabant/vim-gutentags' " tags file management

" language/programming tools
Plug 'w0rp/ale' " asynchroneous lint engine - code checking etc.
Plug 'airblade/vim-gitgutter' " git diff in the 'gutter' (sign column)
Plug 'tpope/vim-fugitive' " git wrapper for vim
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' } " LSP support
Plug 'jpalardy/vim-slime' " REPL in vim
Plug 'lervag/vimtex', { 'for': ['tex', 'latex', 'bib'] } " LaTeX
Plug 'python-mode/python-mode', { 'branch': 'develop' } " convert vim into a Python IDE
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' } " markdown
Plug 'jalvesaq/Nvim-R', { 'for': 'R' } " convert vim into an R IDE

" snippets
Plug 'Shougo/neosnippet.vim' " snippet support for vim
Plug 'Shougo/neosnippet-snippets' " default set of snippets

" colorschemes
Plug 'lifepillar/vim-solarized8' " preferred dark theme
Plug 'mhartington/oceanic-next' " preferred light theme

call plug#end()


" << BASIC SETTINGS >> -------------------------------------------------------


filetype on " filetype detection on
filetype plugin on " filetype based plugins on
filetype indent on " filtype specific indentation on
syntax on " enable syntax highlighting

set ignorecase " case insensitive search by default
set smartcase " case sensitive search if large caps in in the pattern
set hlsearch " highlight matched patterns (:noh clear until next search)
set incsearch " show matched patterns as they are typed
set inccommand=split "substitute live preview neovim >=0.1.7
set gdefault " default to global substitute match. turn of with g flag

set tabstop=4 " size of a tab character
set softtabstop=4 " size of a newly entered tab character
set shiftwidth=4 " indent size
set expandtab " expand tab to spaces

set breakindent " keeps indentation for line wraps
set autoindent " copy indetation from the previous line
set linebreak " break line at word endings only

set foldmethod=syntax " let syntax highlighting specify folding
set foldnestmax=1 " maximum number of nested folds

set modelines=0 " modelines is a security concern
set showcmd " show letters typed in the left part of the bottom row
set hidden " hide buffer when moving to other ones
set mouse=a " enable mouse usage in all modes
set wildmode=longest,list,full " completion mode settings
set wildignore=*.aux,*.fdb_latexmk,*.fls,*.synctex.gz,*.pdf,*.run.xml,
        \*.bbl,*.db_latexmk,*.nav,*.snm
set noswapfile " no swap file

autocmd FileType md,markdown,Rmd,txt,tex,bib, setlocal spell spelllang=en_us

" << LATEX OPTIONS >>

let g:tex_flavor="latex"
set conceallevel=0
let g:tex_conceal="abmg"
let g:tex_comment_nospell=1


" << APPEARANCE >> -----------------------------------------------------------


set ruler " status bar position details
set colorcolumn=80 " highlight 80th column
set number " show line numbers
set relativenumber " use relative instead of absoulte line numbers
set termguicolors " use 24 bit colors in terminal
set background=dark " set background to dark
colorscheme OceanicNext " set default colorscheme

" function for toggling between dark and light theme
function ToggleColors()
	if g:colors_name == "OceanicNext"
		let &background = "light"
		colorscheme solarized8
	else
		colorscheme OceanicNext
	endif
endfunction

" cursor shape: blinking, etc
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
        \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		\,sm:block-blinkwait175-blinkoff150-blinkon175

" set window title to file name
set titlestring=%t%(\ %m%r%)%(\ (%{expand(\"%:p:h:t\")})%)
set title " set window title to the value in titlestring


" << GENERAL KEYBINDINGS >> --------------------------------------------------


nmap <leader>fr :%s///<left><left><left>
vmap <leader>fr :s///<left><left><left>

nmap d/ :let @/=""<CR>

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

map <F5> :call ToggleColors()<CR>

inoremap { {}<left>
inoremap {{ {
inoremap {} {}<left>

inoremap ( ()<left>
inoremap (( (
inoremap () ()<left>

inoremap [ []<left>
inoremap [[ [
inoremap [] []<left>

vnoremap > >gv
vnoremap < <gv

imap jj <Esc>


" << PLUGIN OPTIONS >> -------------------------------------------------------


" << AIRLINE >>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_theme='oceanicnext'
let g:airline#extensions#vimtex#enabled = 1

" << ALE >>

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" << DEOPLETE >>

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = '\\(?:'
      \ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
      \ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
      \ . '|hyperref\s*\[[^]]*'
      \ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|(?:include(?:only)?|input)\s*\{[^}]*'
      \ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
      \ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|usepackage(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|documentclass(\s*\[[^]]*\])?\s*\{[^}]*'
      \ . '|\w*'
      \ .')'
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.tex = '\\?[a-zA-Z_]\w*'

inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

" << FZF >>

nnoremap <C-t> :Files
nnoremap gb :Buffers<CR>
nnoremap <leader>zb :Buffers<CR>
nnoremap <leader>zl :Lines<CR>
nnoremap <leader>zh :History<CR>
nnoremap <leader>z: :History:<CR>
nnoremap <leader>z/ :History/<CR>
nnoremap <leader>zs :Snippets<CR>

" << GUTENTAGS >>

if !executable('ctags')
    let g:gutentags_dont_load = 1
endif

" << NEOSNIPPET >>

imap <C-l> <Plug>(neosnippet_expand_or_jump)
smap <C-l> <Plug>(neosnippet_expand_or_jump)
xmap <C-l> <Plug>(neosnippet_expand_target)

" << NETRW >>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" << PYTHON-MODE >>

let g:pymode_python = 'python3' " preferred version of python

" << UNDOTREE >>

nnoremap <leader>ut :UndotreeToggle<CR>

" << VIMTEX >>

let g:vimtex_fold_enabled = 1 " enable folding
let g:vimtex_indent_enabled = 1 " enable vimtex indentation
let g:vimtex_format_enabled = 1 " enable vimtex formatting
let g:vimtex_indent_on_ampersands = 0 " do not align on &
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_fold_types = {
        \ 'envs' : {
        \   'enabled' : 0,
        \   'whitelist' : [
        \     'abstract',
        \   ],
        \ },
        \ 'sections' : {
        \   'sections' : [
        \     'part',
        \     'chapter',
        \     'section',
        \     'subsection'
        \   ]  
        \ }
        \}

" << VIM-MARKDOWN >>

let g:vim_markdown_folding_level = 2 " number of sections to fold
let g:tex_conceal = "" " do not conceal LaTeX in markdown files
let g:vim_markdown_math = 1 " highlighting for LaTeX in markdown files
let g:vim_markdown_frontmatter = 1 " highlighting for YAML front matter

" << VIM-SMOOTH-SCROLL >>

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 20, 2)<CR>

" << VIM-SURROUND >>

let g:surround_{char2nr('s')} = "\\{\r\\}"
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"


" << TEMPLATES >> ------------------------------------------------------------


augroup FileTemplates
    autocmd!
    autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/bash.skeleton
    autocmd BufNewFile *.py 0r ~/.config/nvim/templates/python.skeleton
    autocmd BufNewFile *.md 0r ~/.config/nvim/templates/markdown.skeleton
    autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/latex.skeleton
    autocmd BufNewFile *.[rR] 0r ~/.config/nvim/templates/r.skeleton
augroup END
