""""""""""""""""""""""""""""""""""""""""""""""
"	    UTILITY FUNCTIONS		     "
""""""""""""""""""""""""""""""""""""""""""""""

" Create a scratched buffer

function! s:CreateGraphBuffer()
  :new
  :setlocal buftype=nofile
  :setlocal bufhidden=hide
  :setlocal noswapfile
  :setlocal nobuflisted
endfunction

" Draw a gnuplot graph for a given filename

function! s:GnuplotDraw(filename)
  :execute "r!gnuplot -e \"set terminal dumb; plot '".a:filename."' pt 7 noti\""
endfunction

" Save the content of the register "t to a given file

function! s:SaveRegisterToFile(filename)
  :new
  :0		    " move to the top
  :put! t	    " print content of register t
  :execute "write! ".a:filename
  :execute "bd ".a:filename
endfunction

""""""""""""""""""""""""""""""""""""""""""""""
"	    PUBLIC FUNCTIONS		     "
""""""""""""""""""""""""""""""""""""""""""""""

function! GenerateGraph()
  :call s:SaveRegisterToFile("tmp.dat")
  :call s:CreateGraphBuffer()
  :call s:GnuplotDraw("tmp.dat")
  :!rm -f "tmp.dat"
endfunction

""""""""""""""""""""""""""""""""""""""""""""""
"		MAPPINGS       		     "
""""""""""""""""""""""""""""""""""""""""""""""

vnoremap <leader>cg :yank t<CR>:call GenerateGraph()<CR>
