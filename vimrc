set t_Co=256
let g:syntastic_python_checkers=['pylint']
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_enable_signs=1
let g:syntastic_enable_highlighting=1
execute pathogen#infect()
runtime! plugin/sensible.vim
syntax on
filetype on
filetype plugin on
" How many tabs
set ts=3 "Length of tab
set sw=3 "Length to shift (1 tab)
set ai "Auto indent
set ci "copy indent
set nu " line numbers

"  Ignore case if all lowercase search.
set ignorecase
set smartcase
"  incremental search while typing
set incsearch
"  show matching brackets
set showmatch
" highlight search results
set hlsearch
"  numbering at side of file (better for movement/deletion)
set relativenumber
"  File tabbing
set wildmenu
"  First tab extends to longest, and lists matches.
"  subsequent tabs iterate through the list.
set wildmode=longest:list,full
" Ignore compiled files
set wildignore=*.pyc,*.beam,*.so

" Use middle click copy/paste
set clipboard=unnamed
" replace text with copied text
nnoremap  S "_diwP

" clear search command
nnoremap <leader><space> :noh<cr>
" Clear trailing whitespace in file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"shortcut to set folding on
nnoremap <leader>z :set foldmethod=indent<CR>
" fold/unfold with space
nnoremap <space> za

nnoremap <leader>j :! pdflatex %<CR>

" Appearance
set background=dark
colo evening
":highlight Normal ctermbg=black
"  display tabs, trailing spaces
set list
set lcs=tab:>-,trail:@


"  Speed of common comands
nnoremap ; :
nnoremap <leader>; ;
nnoremap <leader>, ,
nmap , <leader>
" more sensible up down movement
nnoremap j gj
nnoremap k gk
"  Easier moving to begin/end of line
nnoremap <leader>f ^
nnoremap <leader>g $

"  Quick vimrc editing
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"  Shortcuts to split windows
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>d <C-w>s<C-w>j
"  Shortcuts to move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


"  Disallow arrow keys for movement.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>


" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

set ofu=syntaxcomplete#Complete
set completeopt+=longest,menuone
highlight Pmenu guibg=brown gui=bold




" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) <= indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [J :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> [j :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]J :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> ]j :call NextIndent(1, 1, 0, 1)<CR>

onoremap <silent> [J :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> [j :call NextIndent(0, 0, 1, 1)<CR>
onoremap <silent> ]J :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> ]j :call NextIndent(1, 1, 0, 1)<CR>
