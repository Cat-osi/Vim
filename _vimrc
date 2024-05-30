" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Remap a few keys for Windows behavior
" source $VIMRUNTIME/mswin.vim

syntax enable

set background=dark

let g:solarized_termcolors=256

colorscheme nord

" 显示行号'
set nu
set number

" 设置Tab长度为4空格
set tabstop=4
" 设置自动缩进长度为4空格
set shiftwidth=4
" 继承前一行的缩进方式，适用于多行注释
set autoindent

set paste

set listchars=tab:>-,trail:-

" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler

" 设置编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

set langmenu=zh_CN.UTF-8                 "设置菜单语言
source $VIMRUNTIME/delmenu.vim    "导入删除菜单脚本，删除乱码的菜单
source $VIMRUNTIME/menu.vim          "导入正常的菜单脚本
language messages zh_CN.utf-8          "设置提示信息语言

" 设置行数
:set lines=50

" 设置列数
:set columns=200

"设置gvim窗口启动时在屏幕的位置
winpos 100 100

" 取消生成文件un, text
set nobackup
set noundofile

" 显示相对行号
set relativenumber number

set guifont=Consolas:h9

call plug#begin('~/.vim/plugged')
" 在这里使用 Plug "github用户/项目名" 的方式引入插件
"
" 彩虹括号
Plug 'luochen1990/rainbow'
Plug 'Lokaltog/vim-powerline' " 状态栏增强插件
" 历史记录
Plug 'mhinz/vim-startify'
"
Plug 'preservim/nerdtree'
"设置按F2启动NerdTree
map <F2> :NERDTreeToggle<CR>
call plug#end()






" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

