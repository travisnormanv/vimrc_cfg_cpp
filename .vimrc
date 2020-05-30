" tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" max column settings
set colorcolumn=110
highlight ColorColumn ctermbg=darkgray


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" NERDtree
Plugin 'preservim/nerdtree'

" YouCompleteMe
Plugin 'ycm-core/YouCompleteMe'  

" asyncrun
Plugin 'skywind3000/asyncrun.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" NERDtree
map <C-n> :NERDTreeToggle<CR>
" exclude files
let NERDTreeIgnore=['\(.hpp\|.cpp\)\@<!$[[file]]']	
let NERDTreeIgnore+=['^build$']	
let NERDTreeIgnore+=['^exe$']	
" autostart nerdtree
function! StartVim()
	if &filetype ==# 'cpp' || &filetype ==# 'hpp'
		" enable line numbers
		let NERDTreeShowLineNumbers=1
		" make sure relative line numbers are used
		autocmd FileType nerdtree setlocal relativenumber
		NERDTree
	endif	
endfunction

autocmd vimenter * call StartVim() | wincmd p


" YCM
let g:ycm_autoclose_preview_window_after_insertion=1

autocmd BufWritePost * YcmRestartServer

" asyncrun
let g:asyncrun_open=10
nnoremap <F10> :call asyncrun#quickfix_toggle(10) <cr>
"
" build output directory
let s:bod='./build'

" cmake
function! CMake()
	execute 'AsyncRun cmake -B ' . s:bod
endfunction

" build project
function! Build()
	execute 'AsyncRun make -sC' . s:bod 
endfunction

" run
function! Run()
	execute 'AsyncRun make -sC' . s:bod ' run'
endfunction

nnoremap <F4> :call CMake() <cr>
nnoremap <F5> :call Build() <cr>
nnoremap <F6> :call Run() <cr>
