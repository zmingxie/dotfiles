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

"Shows a $ sign at the end of each line and shows ^I instead of tabs.
set list
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

" Spli window on the right instead of default
set splitright

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

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

" Automatically set paste mode in Vim when pasting in insert mode
" Credits: https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" Enable fuzzy search
set rtp+=/usr/local/opt/fzf
