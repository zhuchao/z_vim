syntax on
set runtimepath=/home/liangjun/Vim/

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

""""""""""""""基本设置"""""""""
"文件在Vim之外修改过，自动重新读入
set autoread

"设置默认打开字符编码
set encoding=utf8

"设置tab的长度等于4个空格
set tabstop=4

set wildmenu

"设置选中之后按*和#就可以对选中的部分进行查找
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"设置vim文件浏览
let g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer'
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <F8> :WMToggle<cr>


"""""""""""""样式""""""""""""""

"设置样式,这些样式都在color文件夹下，以下是我喜欢的几个，放这方便切换
colorscheme tango
"colorscheme blink
"colorscheme calmar256
"colorscheme xterm16

"设置搜索高亮显示
set hlsearch

"自动跳转到搜索的字符上
set incsearch

"设置读取文件的格式
set ffs=unix,dos

set foldmethod=marker
let php_folding = 1
let g:winManagerWindowLayout = 'FileExplorer,TagsExplorer|BufExplorer'
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <F8> :WMToggle<cr>



source /home/liangjun/Vim/scripts/closetag.vim

"""""""""符号补全""""""""""""""
"设置高亮宣示匹配的符号
set showmatch

:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>

:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>

:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>


function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
   return a:char
  endif
endf

set wrap

