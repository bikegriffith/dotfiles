" .vimrc
"
" @author Mike Griffith
" @website http://www.mike-griffith.com
"

set nocompatible     " use vim defaults (this should be first in .vimrc)

filetype plugin on   " load ftplugin.vim
filetype indent on   " load indent.vim


"###############################
"  Generic Settings
"###############################

" File
set fileformat=unix
set directory=~/tmp
set dir=~/tmp,.,/tmp,/var/tmp
"set backup           " make a backup before overwriting a file
set binary            " show control characters (ignore 'fileformat')
set autoread          " automatically read file changed outside of Vim
set autowrite         " automatically save before commands like :next and :make
set suffixes+=.class,.pyc   " skip bytecode files for filename completion
set suffixes-=.h      " do not skip C header files for filename completion

" Memory
"  '10  : marks will be remembered for up to 10 previously edited files
"  "100 : will save up to 100 lines for each register
"  :20  : up to 20 lines of command-line history will be remembered
"  %    : saves and restores the buffer list
"  n... : where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" Color scheme
set t_Co=256
colo inkpot

" Interface
set showmatch         " when a bracket is inserted, briefly jump to the match
set guifont=-misc-fixed-medium-r-normal--15-140-75-75-c-90-iso8859-1
set cinoptions=>s,e0,n0,f0,{0,}0,^0,:0,=s,ps,ts,+s,(2s,)20,*30
set history=1000      " number of commands and search patterns to save
set background=dark   " set terminal background (see F11)
set ttyfast           " smoother display on fast network connections
set showcmd           " show partial command in status line
set laststatus=2      " always show statusline
set statusline=%n\ %1*%h%f%*\ %=%<[%3lL,%2cC]\ %2p%%\ 0x%02B%r%m
set wildmenu          " show a menu of matches when doing completion

" Search
set ignorecase
set incsearch	      " incremental search
let c_comment_strings=1   " highlight strings inside C comments
set hlsearch          " highlight the current search pattern
"set nohlsearch	      " no search hightlighting

" Window panes
set splitbelow        " open new split windows below the current one
set winminheight=0    " makes more sense than the default of 1
set noequalalways     " do not resize windows on split/close

" Editor
set autoindent smarttab
set nowrap              " don't wrap long lines
set whichwrap=b,s,h,l,<,>,[,]   " wrap to the previous/next line on all keys
set textwidth=80
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set shiftround        " align to standard indent when shifting with < and >
set expandtab
set formatoptions+=r  " auto-format comments while typing
set nojoinspaces      " use only one space when using join
set matchpairs+=<:>   " add < > to chars that form pairs (see % command)
set showmatch         " show matching brackets by flickering cursor
set matchtime=1       " show matching brackets quicker than default
set virtualedit=block " allow Visual block select anywhere
"set ruler            " show ruler, but only shown if laststatus is off
"set rulerformat=%h%r%m%=%f " sane value in case laststatus is off
set number           " show line numbers




"###############################
"  Key-maps
"###############################

" Indentation in visual mode
" Keeps the visual selection active after indenting.
vmap > >gv
vmap < <gv

" Use display movement with arrow keys for extra precision. Arrow keys will
" move up and down the next line in the display even if the line is wrapped.
" This is useful for navigating very long lines that you often find with
" automatically generated text such as HTML.
" This is not useful if you turn off wrap.
imap <up> <C-O>gk
imap <down> <C-O>gj
nmap <up> gk
nmap <down> gj
vmap <up> gk
vmap <down> gj

" Autocomplete with tab while in insert mode (ctrl+n or ctrl+p by default)
"inoremap <tab> <c-n>
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>


" Split window navigation
"nmap <c-down> <c-w>w
"nmap <c-up> <c-w>W
"nmap <c-left> <c-w>h
"nmap <c-right> <c-w>l

" Tab support
if version >= 700
    map <S-left> :tabp<CR>
    map <S-right> :tabn<CR>
endif





"###############################
"  UI Enhancements
"###############################

" Highlight lines over 80 characters
"highlight LineTooLong ctermbg=darkred ctermfg=white guibg=#592929
"match LineTooLong /\%81v.*/

" Highlight extra spaces at the end of line
" VimDiff doesn't like this, so only do it for regular
if !&diff
    highlight ExtraSpaces ctermbg=red ctermfg=white guibg=red
    match ExtraSpaces /\s\+$/
endif

" Syntax highlighting
syntax on
:set t_Co=8
:set t_Sf=[3%p1%dm
:set t_Sb=[4%p1%dm
:set background=dark
:let filetype_pd = "html"
":source $VIM/syntax/syntax.vim

" Restore cursor position on load
" :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup JumpCursorOnEdit
    au!
    autocmd BufReadPost *
        \ if expand("<afile>:p:h") !=? $TEMP |
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ let JumpCursorOnEdit_foo = line("'\"") |
        \ let b:doopenfold = 1 |
        \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
        \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
        \ let b:doopenfold = 2 |
        \ endif |
        \ exe JumpCursorOnEdit_foo |
        \ endif |
        \ endif
    " Need to postpone using "zv" until after reading the modelines.
    autocmd BufWinEnter *
        \ if exists("b:doopenfold") |
        \ exe "normal zv" |
        \ if(b:doopenfold > 1) |
        \ exe "+".1 |
        \ endif |
        \ unlet b:doopenfold |
        \ endif
augroup END



"###############################
"  Macros
"###############################

"** <enter>     Clear search
"** <F5>        Clear folds and redraw window
"** <F6> or \ds SVN diff
"** <F7> or \n  Toggle line #'s
"** <F8> or \a  Yank all lines
"** <F9>        Kill all trailing whitespace
"** <F10> or \r Reindent file
"** <F11>       Run buffer in xterm

" Clear search highlight in normal mode
nnoremap <silent><CR> :nohlsearch<CR><CR>

" <F5> to clear folds and redraw window
map <silent><F5> :call RedrawWindow()<CR>
function! RedrawWindow()
    set nofoldenable
    set foldcolumn=0
    :redraw!
endfunction

" <F6> to vimdiff against HEAD in SVN.
map <silent><F6> :call SVNDiff()<CR>
map <silent><leader>ds :call SVNDiff()<CR>
function! SVNDiff()
    let fn = bufname("%")
    let newfn = fn . ".HEAD"
    let catstat = system("svn cat -r HEAD " . fn . " > " . newfn)
    if stridx(catstat, "is not a working copy") > 0
        echo "*** ERROR ***\n" . catstat
    else
        execute "vert diffsplit " . newfn
    endif
    let rmstat = system("rm " . newfn)
endfunction

" <F7> to toggle line numbers
map <silent><F7> :set number!<CR>
map <silent><leader>n :set number!<CR>

" <F8> to yank all lines
map <silent><F8> gg"+yG
map <silent><leader>a gg"+yG

" <F9> to kill trailing whitespace on all lines in file
map <silent><F9> :call KillTrailingWS()<CR>
function! KillTrailingWS()
    :%s/\s*$//g
endfunction

" <F10> to reindent file
map <silent><F10> mzgg=G`z
map <silent><leader>r mzgg=G`z

" <F11> Run the current buffer in an X terminal that disappears after 5 minutes.
" Needs the env var $TERM set to xterm or some compatible X11 terminal.
" This does not save first!
map <silent><F11> :call RunBufferInTerm()<CR>
function RunBufferInTerm ()
    if &filetype == 'python'
        silent !$TERM -bg black -fg green -e bash -c "python %; sleep 300" &
    elseif &filetype == 'sh'
        silent !$TERM -bg black -fg green -e bash -c "./%; sleep 300" &
    elseif &filetype == 'php'
        silent !$TERM -bg black -fg green -e bash -c "php %; sleep 300" &
    elseif &filetype == 'perl'
        silent !$TERM -bg black -fg green -e bash -c "perl %; sleep 300" &
    endif
    sleep 1
    redraw!
endfunction



"###############################
"  Python Unit Testing
"
"  Based on Gary Bernhardt's .vimrc:
"  http://bitbucket.org/garybernhardt/dotfiles/src/tip/.vimrc
"
"  <F1> Run test for current module
"  <F2> Run all tests at or below currently edited module
"  <F3> Toggle between unit test and module
"
"  Depends on repository layout as such:
"    |package/
"    |....__init__.py
"    |....module1.py
"    |....module2.py
"    |....tests/
"    |........__init__.py
"    |........test_module1.py
"    |........test_module2.py
"###############################

function! ClassToFilename(class_name)
    let understored_class_name = substitute(a:class_name, '\(.\)\(\u\)', '\1_\U\2', 'g')
    let file_name = substitute(understored_class_name, '\(\u\)', '\L\1', 'g')
    return file_name
endfunction

function! ModuleTestDirectory()
    " 1/7/2010 - mgriffith - new function
    let file_path = @%
    let components = split(file_path, '/')
    if components[:-2] != []
        let dir = join(components[:-2], '/')
        let test_path = dir . '/tests'
        return test_path
    else
        let test_path = 'tests'
        return test_path
    endif
endfunction

function! CurrentFileName()
    " 1/7/2010 - mgriffith - new function
    let file_path = @%
    let components = split(file_path, '/')
    let filename = components[-1]
    return filename
endfunction

function! ModuleTestPath()
    " 1/7/2010 - mgriffith - updated to match AGI nomenclature
    let filename = CurrentFileName()
    let test_dir = ModuleTestDirectory()
    let test_path = test_dir . '/test_' . filename
    return test_path
endfunction

function! NameOfCurrentClass()
    let save_cursor = getpos(".")
    normal $<cr>
    call PythonDec('class', -1)
    let line = getline('.')
    call setpos('.', save_cursor)
    let match_result = matchlist(line, ' *class \+\(\w\+\)')
    let class_name = ClassToFilename(match_result[1])
    return class_name
endfunction

function! TestFileForCurrentClass()
    " 1/7/2010 - mgriffith - each class shares same test module at AGI
    let filename = CurrentFileName()
    if filename =~ 'test_'
        " don't open tests for tests
        return @%
    else
        let test_file_name = ModuleTestPath()
        return test_file_name
    endif
endfunction

function! CodeFileForCurrentTest()
    " 1/28/2010 - mgriffith - find the code for this test
    let filename = CurrentFileName()
    if filename =~ 'test_'
        return substitute(@%, "tests/test_", "", "g")
    else
        return filename
    endif
endfunction

function! RunTestsForFile(args)
    let filename = CurrentFileName()
    let test_file_name = ModuleTestPath()
    if filename =~ 'test_'
        " this appears to be a test, run it
        call RunTests('%', a:args)
    elseif filename =~ '__init__'
        " for __init__, run all the tests
        call RunTests(ModuleTestDirectory(), a:args)
    elseif filereadable(test_file_name)
        " looks like we have a good test for this module
        call RunTests(test_file_name, a:args)
    else
        " couldn't find a test for this module, run all tests underneath
        call RunTests('', a:args)
    endif
endfunction

function! RunTests(target, args)
    silent ! echo
    exec 'silent ! echo -e "\033[1;36mRunning tests in ' . a:target . '\033[0m"'
    " 1/7/2010 - mgriffith - added my own personal test runner in $HOME/bin
    "     that suppresses ok output amongst other things
    set makeprg=nosequiet
    " FIXME: this will always grab the first piece of the stack trace (which is
    " incidentally not usually what caused the exception).  It would be nice to
    " be less greedy more lazy and grab the last one.
    set errorformat=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent w
    exec "make " . a:target . " " . a:args
endfunction

function! RunAllTests(args)
    call RunTests('', args)
endfunction

function! JumpToError()
    if getqflist() != []
        for error in getqflist()
            " FIXME: be smarter about determining what is and isn't a real
            " error, and allow additional output even when things are ok.
            " Maybe QuickFix buffer isn't the right way to go???
            if error['valid']
                break
            endif
        endfor
        let error_message = substitute(error['text'], '^ *', '', 'g')
        silent cc!
        " 1/7/2010 - mgriffith - removed jump to buffer because thowing erro
        "echo error
        "exec ":sbuffer " . error['bufnr']
        call RedBar()
        echo error_message
    else
        call GreenBar()
        echo "All tests passed"
    endif
endfunction

function! RedBar()
    hi RedBar ctermfg=white ctermbg=red guibg=red
    echohl RedBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

function! GreenBar()
    hi GreenBar ctermfg=white ctermbg=green guibg=green
    echohl GreenBar
    echon repeat(" ",&columns - 1)
    echohl
endfunction

function! JumpToTestsForClass()
    let filename = CurrentFileName()
    if filename =~ 'test_'
        exec 'e ' . CodeFileForCurrentTest()
    else
        exec 'e ' . TestFileForCurrentClass()
    endif
endfunction

"let mapleader=","
"nnoremap <leader>m :call RunTestsForFile('--machine-out')<cr>:redraw<cr>:call JumpToError()<cr>
"nnoremap <leader>M :call RunTestsForFile('')<cr>
"nnoremap <leader>a :call RunAllTests('--machine-out')<cr>:redraw<cr>:call JumpToError()<cr>
"nnoremap <leader>A :call RunAllTests('')<cr>
"nnoremap <leader>t :call JumpToTestsForClass()<cr>
"nnoremap <leader><leader> <c-^>

" Execute unit tests for currently edited file
map <silent><F1> :call RunTestsForFile('')<cr><cr>:redraw<cr>:call JumpToError()<cr>
map <silent><F2> :call RunAllTests('')<cr><cr>:redraw<cr>:call JumpToError()<cr>

" Open test file for currently edited file
map <silent><F3> :call JumpToTestsForClass()<cr>




"###############################
"  Filetype-specific overrides
"###############################

" 2 space indent overrides
autocmd BufRead,BufNewFile *.html,*.js setl sw=2 sts=2 et
autocmd BufRead,BufNewFile *.html setl textwidth=120

augroup python
    au!
    autocmd BufRead,BufNewFile *.py setl ts=4 sw=4 softtabstop=4 et
    " make indentation a little smarter
    autocmd BufRead,BufNewFile *.py setl smarttab softtabstop=4 et
    autocmd BufRead,BufNewFile *.py setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,do,switch
    inoremap # X<C-H>#
augroup end

"augroup javascript
"    au!
"    autocmd BufRead,BufNewFile *.js set ts=4 sw=4 smarttab softtabstop=4 et
"augroup end

" Templates for new files. Silent if the template for the
" extension does not exist. This just loads what extension matches in
" $VIMHOME/templates/. For example the contents of html.tpl would be loaded
" for new html documents.
augroup BufNewFileFromTemplate
    au!
    autocmd BufNewFile * silent! 0r $HOME/.vim/templates/%:e.tpl
    autocmd BufNewFile * normal! G"_dd1G
    autocmd BufNewFile * silent! match Todo /TODO/
augroup BufNewFileFromTemplate


"###################
"    Pathogen
"###################

let NERDTreeIgnore = ['\.pyc$']

execute pathogen#infect()
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" <ctrl>+n to toggle NERDTree
map <silent> <C-n> :NERDTreeToggle<CR>

