let g:gtrans_input_language = 'auto'
let g:gtrans_output_language = 'de'

function! GtransLanguage(...) range
    if a:0 == 0
        let g:gtrans_input_language = 'auto'
        let g:gtrans_output_language = 'de'
    elseif a:0 == 1
        let g:gtrans_output_language = a:1
    else
        let g:gtrans_input_language = a:1
        let g:gtrans_output_language = a:2
    endif
endfunction

command! -nargs=* GtransLanguage call GtransLanguage(<f-args>)

" nnoremap <Leader>tr :call Gtrans()<CR>
vnoremap <Leader>tr :call Gtrans()<CR>

" redir_messages.vim
"
" Inspired by the TabMessage function/command combo found
" at <http://www.jukie.net/~bart/conf/vimrc>.
"

function! RedirMessages(msgcmd, destcmd)
"
" Captures the output generated by executing a:msgcmd, then places this
" output in the current buffer.
"
" If the a:destcmd parameter is not empty, a:destcmd is executed
" before the output is put into the buffer. This can be used to open a
" new window, new tab, etc., before :put'ing the output into the
" destination buffer.
"
" Examples:
"
"   " Insert the output of :registers into the current buffer.
"   call RedirMessages('registers', '')
"
"   " Output :registers into the buffer of a new window.
"   call RedirMessages('registers', 'new')
"
"   " Output :registers into a new vertically-split window.
"   call RedirMessages('registers', 'vnew')
"
"   " Output :registers to a new tab.
"   call RedirMessages('registers', 'tabnew')
"
" Commands for common cases are defined immediately after the
" function; see below.
"
    " Redirect messages to a variable.
    "
    redir => message

    " Execute the specified Ex command, capturing any messages
    " that it generates into the message variable.
    "
    silent execute a:msgcmd

    " Turn off redirection.
    "
    redir END

    " If a destination-generating command was specified, execute it to
    " open the destination. (This is usually something like :tabnew or
    " :new, but can be any Ex command.)
    "
    " If no command is provided, output will be placed in the current
    " buffer.
    "
    if strlen(a:destcmd) " destcmd is not an empty string
        silent execute a:destcmd
    endif

    " Place the messages in the destination buffer.
    "
    silent put=message

endfunction

" Create commands to make RedirMessages() easier to use interactively.
" Here are some examples of their use:
"
"   :BufMessage registers
"   :WinMessage ls
"   :TabMessage echo "Key mappings for Control+A:" | map <C-A>
"
command! -nargs=+ -complete=command BufMessage call RedirMessages(<q-args>, ''       )
command! -nargs=+ -complete=command WinMessage call RedirMessages(<q-args>, 'new'    )
command! -nargs=+ -complete=command TabMessage call RedirMessages(<q-args>, 'tabnew' )

" end redir_messages.vim
