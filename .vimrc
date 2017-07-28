"ctags -R --fields=+laimS --languages=php
colors darkblue
set nu
set nobackup
set nowritebackup
set noswapfile
set clipboard=unnamedplus
set fileencodings=utf-8,gbk,utf-16,big5
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set ruler
set hlsearch
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Bundle 'VundleVim/Vundle.vim'
Bundle 'L9'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-pathogen'
Bundle 'Shougo/unite.vim'
Bundle 'captbaritone/better-indent-support-for-php-with-html'
Bundle 'mikehaertl/yii2-apidoc-vim'
Bundle 'vim-syntastic/syntastic'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'xolox/vim-misc'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-projectionist'
Bundle 'jwalton512/vim-blade'
Bundle 'tpope/vim-dispatch'
Bundle 'KabbAmine/gulp-vim'
Bundle 'posva/vim-vue'
Bundle 'mattn/emmet-vim'
Bundle 'vim-scripts/PDV--phpDocumentor-for-Vim'
Bundle 'fatih/vim-go'
Bundle 'noahfrederick/vim-composer'
Bundle 'majutsushi/tagbar'
call vundle#end()            " required
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd QuickFixCmdPost *grep* cwindow
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

filetype plugin indent on
syntax on
set completeopt=longest,menu

if has("mmulti_byte")
    if &termencoding = ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8,cp936,gb2312,gbk,gb18030
    setglobal fileencoding=utf-8,gb2312,gbk,gb18030
    setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1,gb2312,gbk,gb18030
endif

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
highlight Pmenu ctermfg=white ctermbg=black
highlight PmenuSel ctermfg=black  ctermbg=white
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
let g:fugitive_git_executable = "env GIT_SSH_COMMAND='ssh -o ControlPersist=no' git"
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['datetime', 'javascript']

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
let g:blade_custom_directives_pairs = {
      \   'markdown': 'endmarkdown',
      \   'cache': 'endcache',
      \ }

function! GenTags()
    if isdirectory("./vendor")
        echo '(re)Generating framework tags'
        execute "!php artisan ide-helper:generate"
        echo '(re)Generating tags'
        execute "!ctags -R --filter-terminator=php"
    " else
    "     echo 'Not in a framework project'
    "     if filereadable("tags")
    "         echo "Regenerating tags..."
    "         execute "!ctags -R --filter-terminator=php"
    "     else
    "         let choice = confirm("Create tags?", "&Yes\n&No", 2)
    "         if choice == 1
    "             echo "Generating tags..."
    "             execute "!ctags -R --filter-terminator=php"
    "         endif
    "     endif
    endif

:endfunction

command! -nargs=* GenTags call GenTags()
GenTags()

source ~/.vim/bundle/PDV--phpDocumentor-for-Vim/plugin/php-doc.vim
inoremap <F5> <ESC>:call PhpDocSingle()<CR>i
nnoremap <F5> :call PhpDocSingle()<CR>
vnoremap <F5> :call PhpDocRange()<CR>
let g:go_gocode_autobuild = 1
nmap <F8> :TagbarToggle<CR>
