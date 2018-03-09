if (exists('g:loaded_ctrlp_tmuxcaptures') && g:loaded_ctrlp_tmuxcaptures)
      \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_tmuxcaptures = 1

"
" configuration options

call add(g:ctrlp_ext_vars, {
      \ 'init': 'ctrlp#tmuxcaptures#init()',
      \ 'accept': 'ctrlp#tmuxcaptures#accept',
      \ 'lname': 'tmuxcaptures',
      \ 'sname': 'tmuxcaptures',
      \ 'type': 'line',
      \ 'enter': 'ctrlp#tmuxcaptures#enter()',
      \ 'exit': 'ctrlp#tmuxcaptures#exit()',
      \ 'opts': 'ctrlp#tmuxcaptures#opts()',
      \ 'sort': 0,
      \ 'specinput': 0,
      \ })

function! ctrlp#tmuxcaptures#exec(mode)
  let s:tmuxcaptures_opt_for_sensitivity = "-s"
  if a:mode == 'p'
    let s:word = s:word
  elseif a:mode == 'n'
    if (&filetype == 'ruby' || &filetype == 'eruby') && exists("*RubyCursorIdentifier")
      let s:word = RubyCursorIdentifier()
    else
      let s:word = expand('<cword>')
    endif
  else
    let s:word = a:mode
  endif

  call ctrlp#init(ctrlp#tmuxcaptures#id())
endfunction

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#tmuxcaptures#init()
  return split(system(s:path . "/capture-tmux-files.rb '" . s:word . "'"), "\n")
endfunction

" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#tmuxcaptures#accept(mode, str)
  call ctrlp#exit()
  call s:open_file(a:mode, a:str)
endfunction

" (optional) Do something before enterting ctrlp
function! ctrlp#tmuxcaptures#enter()
endfunction

" (optional) Do something after exiting ctrlp
function! ctrlp#tmuxcaptures#exit()
endfunction

" (optional) Set or check for user options specific to this extension
function! ctrlp#tmuxcaptures#opts()
endfunction

" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#tmuxcaptures#id()
  return s:id
endfunction

function! s:open_file(mode, str)
  if match(a:str, ':') != -1
    let [path, line] = split(a:str, ':')
    call ctrlp#acceptfile(a:mode, path)
    call cursor(line, 0)
  else
    call ctrlp#acceptfile(a:mode, a:str)
  endif
endfunction
