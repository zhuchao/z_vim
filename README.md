# My vimrc
用vim有6年了，这些配置都是一点点积累起来

最近两周，参考https://github.com/amix/vimrc ，做了整理。

## 安装
	git clone https://github.com/liangjun0305/myvim.git  ~/.vimConfig
	echo 'set runtimepath+=~/.vimConfig/
	source ~/.vimConfig/basic.vim
	' > ~/.vimrc

## 使用到的插件
* [bufexplorer.vim](https://github.com/tpope/vim-pathogen): 缓冲资源浏览器，使用快捷键`\be`,`\bs`,`\bv`快捷键切换
* [NERD Tree](https://github.com/scrooloose/nerdtree): 树形文件资源浏览器,使用`<Ctrl+n>`快捷键切换
* [AutoTmpl](http://www.vim.org/scripts/script.php?script_id=2460): 模板自动记载（我使用中的脚本自己做了修改）
* [pathogen.vim](https://github.com/tpope/vim-pathogen)NERD Tree的依赖包

## 配色
地址：http://vimcolorschemetest.googlecode.com/svn/html/index-c.html

这里有很多，别挑花眼了
