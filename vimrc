syntax on
set nu
set tabstop=2
set shiftwidth=2
set expandtab
set background=dark
set backspace=indent,eol,start
colorscheme ir_black
hi Search cterm=NONE ctermfg=grey ctermbg=darkyellow
set hlsearch
call pathogen#infect()

"Always use unix line endings"
set ff=unix
"Show (partial) command in status line.
set showcmd

"Show matching brackets.
set showmatch

"Do case insensitive matching
set ignorecase

"Do smart case matching
set smartcase

"Incremental search
set incsearch

"Automatically save before commands like :next and :make
set autowrite

"Hide buffers when they are abandoned
set hidden

" Turn off default mappings imposed by macvim
let macvim_skip_cmd_opt_movement = 1

" From http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Toggle the window manager plugin at startup to visible
autocmd GUIEnter * WMToggle "call ToggleWindowsManager()
