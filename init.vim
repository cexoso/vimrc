set number
syntax on
set expandtab
set autoindent
set ar
let mapleader="\<space>"
set tabstop=2
set softtabstop=2
set shiftwidth=2
set noswapfile
set backspace=2
set ignorecase
set clipboard=unnamed

set foldmethod=indent
set foldlevel=99
set vb t_vb=

nnoremap <leader>ev :e $MYVIMRC<CR>

colorscheme monokai_pro
map! jk <Esc>
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
"
nmap     <Leader>g :Gstatus<CR>gg<c-n>
nnoremap <Leader>d :Gdiff<CR>
"
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:coc_global_extensions = ['coc-tsserver']
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
 
let NERDTreeShowHidden=1
 
 
let g:highlightedyank_highlight_duration = 100

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
" " GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" 
nnoremap <leader>v :NERDTreeFind<cr>
nnoremap <c-b> :NERDTreeToggle<cr>
nnoremap <leader>ee <Esc>:e!<CR>
nnoremap <leader>ww <Esc>:w<CR>
" 
nnoremap <C-p> <Esc>:GFiles<CR>
nnoremap <leader><C-p> <Esc>:GFiles?<CR>
nnoremap <leader>m <Esc>:FZFMru<CR>
" 
nmap <leader>rn <Plug>(coc-rename)
" 
nmap s <Plug>(easymotion-s2)
" 
set hlsearch                " 开启高亮显示结果
set incsearch               " 开启实时搜索功能(输入字符串就跳到匹配位置)
set wildignore=*/node_modules/*
" 
highlight Search ctermbg=21 ctermfg=194
highlight IncSearch ctermbg=black ctermfg=yellow 
highlight MatchParen cterm=underline ctermbg=NONE ctermfg=NONE

" 当光标一段时间保持不动了，就禁用高亮
autocmd cursorhold * set nohlsearch
" 当输入查找命令时，再启用高亮
noremap n :set hlsearch<cr>n
noremap N :set hlsearch<cr>N
noremap / :set hlsearch<cr>/
noremap ? :set hlsearch<cr>?
noremap * *:set hlsearch<cr>
" 
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
" 
nnoremap Q @q
" 
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>
set termguicolors
" 
" 
let $FZF_DEFAULT_OPTS .= ' --inline-info'
" 
" All files
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fd --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))
" 
let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
\ 'bg':         ['bg', 'Normal'],
\ 'preview-bg': ['bg', 'NormalFloat'],
\ 'hl':         ['fg', 'Comment'],
\ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':        ['fg', 'Statement'],
\ 'info':       ['fg', 'PreProc'],
\ 'border':     ['fg', 'Ignore'],
\ 'prompt':     ['fg', 'Conditional'],
\ 'pointer':    ['fg', 'Exception'],
\ 'marker':     ['fg', 'Keyword'],
\ 'spinner':    ['fg', 'Label'],
\ 'header':     ['fg', 'Comment'] }
" 
if exists('$TMUX')
  let g:fzf_layout = { 'tmux': '-p90%,60%' }
else
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
endif

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep -i -w --line-number -- '.shellescape(<q-args>).' :!test', 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

inoremap <silent><expr> <space> UltiSnips#CanExpandSnippet() ==# 0 ? "\<space>" : "\<C-R>=UltiSnips#ExpandSnippet()<cr>"

let g:UltiSnipsExpandTrigger="<Nop>"
let g:UltiSnipsJumpBackwardTrigger="<Nop>"
let g:UltiSnipsJumpForwardTrigger="<Nop>"

let g:rooter_patterns = ['.git']

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ UltiSnips#CanJumpForwards() ? "\<C-O>:call UltiSnips#JumpForwards()<cr>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB>
      \ pumvisible() ? "\<C-p>" : 
      \ UltiSnips#CanJumpBackwards() ? "\<C-O>:call UltiSnips#JumpBackwards()<cr>" :
      \ "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" 
" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>ag       :GGrep <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :GGrep <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:GGrep <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <C-F> :CocCommand prettier.formatFile<CR>
" Mapping selecting mappings
" nmap <leader><tab> <plug>(fzf-maps-n)
" xmap <leader><tab> <plug>(fzf-maps-x)
" omap <leader><tab> <plug>(fzf-maps-o)
" 
" " Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-l> <plug>(fzf-complete-line)
" nmap <C-t>   :tabnew<cr>
" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> gh :call <SID>show_documentation()<CR>

autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview
helpt ALL
