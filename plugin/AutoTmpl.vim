"=============================================================================
" File:       AutoTmpl.vim
" Maintainer: Lluis Vilanova <vilanova in ac upc edu>
" Modify: jun.liang liangjun0305@gmail.com
" License:    GPL version 3 or any later version
" Created:    2008-09-16
" GetLatestVimScripts: 2460 1 :AutoInstall: AutoTmpl.vim
"-----------------------------------------------------------------------------
" Description:
"   Automatically use and insert dynamic fields in a template when creating new
"   files.
"
" Usage:
"   See ':help AutoTmpl' for a complete description
"   (http://www.vim.org/scripts/script.php?script_id=2460).
"-----------------------------------------------------------------------------
" History:
"   * 2008-09-16 -- Initial version
"   * 2013-6-9 -- edit function LoadTemplateFile GetTemplateFile
"
" TODO:
"   None by now.
"=============================================================================

if exists("g:loaded_autotmpl")
    finish
endif
let g:loaded_autotmpl = 1

" Callback on new files
autocmd BufNewFile * :call <SID>MaybeLoadTemplate(1)

" User commands
command -nargs=0 LoadTemplate call <SID>MaybeLoadTemplate(0)
command -nargs=1 LoadTemplateFile call <SID>LoadTemplateFile(<f-args>)

" Internal code

function <SID>MaybeLoadTemplate(check)
    if a:check && exists("g:load_template") && g:load_template == "no"
        return
    endif
    let extension = expand("%:e")
    if extension == ""
        let file = s:GetTemplateFile(expand("%:t"))
    else
        let file = s:GetTemplateFile("template." . extension)
    endif
    if file == ""
        return
    endif
    if a:check && exists("g:load_template") && g:load_template == "ask"
        let doload = s:ConfirmLoadTemplate(file)
    else
        let doload = 1
    endif
    if doload
        call s:LoadTemplate(file)
    endif
endfunction

function <SID>LoadTemplateFile(file)
	let extension = expand("%:e")
	if exists("g:template_path")
		let file = expand(g:template_path . a:file . "." . extension)
	endif
	if filereadable(file)
		call s:LoadTemplate(file)
	else
		return
    endif
endfunction

function s:GetTemplateFile(template)
    if exists("g:template_path") && filereadable(expand(g:template_path . a:template))
        return expand(g:template_path . a:template)
    else
        return ""
    endif
endfunction

function s:ConfirmLoadTemplate(file)
    let choice = confirm("Load template file " . a:file . "?:", "&yes\n&no\n")
    return choice == 1
endfunction

function s:LoadTemplate(file)
    silent exe "0read " . a:file
    normal G
    normal dd
    silent %s/<?\(\(\(?>\)\@!.\)*\)?>/\=<SID>Compute(submatch(1))/ge
    silent %s/<!\(\(\(!>\)\@!.\)*\)!>/\=<SID>Execute(submatch(1))/ge
    execute 0
    syntax match TemplateMarker "<+\(\(+>\)\@!.\)*+>" containedin=ALL
    highlight link TemplateMarker Search
endfunction

function <SID>Compute(text)
    execute a:text
    return ""
endfunction

function <SID>Execute(text)
    execute "return " . a:text
endfunction

