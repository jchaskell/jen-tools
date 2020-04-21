# Vim
```
I       # insert at beg of line
A       # append at end of line
o       # start inserting on line below
O       # start inserting on line above
```

## Movement
```
e       #move to end of word
w       #move forward to beg of word
fa      # move forward to next "a"
3w      #move forward 3 words
b       #move back to beg of word
3b      #move back 3 words
$       #end of line
0       #beg of line
^       #first non-blank character
)       #forward 1 sentence
(       #back 1 sentence
{       #forward 1 paragraph
}       #back 1  paragraph
H       #top of screen
M       #middle of screen
L       #bottom of screen
G       #end of file
gg      #bottom of file
50G/50  #line 50 
x       #delete character under cursor
daw     #delete word under cursor
^u      #page up
^d      #page down
^O      #jump to previous position system wide
^I      #jump to next position system wide
:jumps  #view recent jumps

yy      #yank (copy) current line
5Y      #yank 5 lines
yaw/yiw #yank 
v/V     #visual mode - lets you highlight by word (v) or by line (V) and then yank
p/P     #paste after/before cursors
```

## Deletion
```
x       # delete current character
dw      # delete current word
dd      # delete current line
5dd     # delete 5 lines

d$      # delete to end of line
d0      # delete to beg of line

dtC     # delete up to next "C"

:1,.d   # delete to beg of file
:.,$d   # delete to end of file
```

## Changing words

```
cw      # change word
ctA     # change up to "A"
cc      # change entire line
ciw     # change inside word (not clear this words differently from cw)
ci(     # change in ()
ci{/<"  # works the same - change inside the markers
ca"     # change around quotes (quotes get replaced too)
```
## Find and Replace
```
:s/foo/bar/g         #change on current line
:%s/foo/bar/g        #change for whole document
:5,12s/foo/bar/g     #change for lines 5-12
:.,$s/foo/bar/g      #change for current line to last line
:.,+2s/foo/bar/g     #change for current line +2
:g/^bax/s/foo/bar/g    #change for lines starting with baz
```

It's also possible to use markers to indicate start/stop
 - need to escape +, ?, |, &, {, ( to use special function; need to escape ., \*, \, [, ^, $ to use real character
```
:s/copyright \zs2007\ze All Rights Reserved/2008/     #replaces just the year in that context
```

If you have a cursor on a word, you can press * to search for it forward or # backward then can sub for it with: `:%s//bar/g`

Search backward with `?` instead of '/'

`3/pattern` searches for the 3rd occurrence of pattern

More complicated stuff:
```
:%s/foo/<c-r><c-w>/g        # press control R/W and it fills in word under cursor
:%s/foo/<c-r>a/g or :%s/foo/<c-r>a/=@a/g    # <c-r> adds contents of register a; =@a doesn’t fill in text (helps with a lot of text)
:%s/foo/<c-r>0/g            # replaces w/ contents of last yank command
:%s/.*/zsfoo/bar/           # on each line, replace last “foo”
:%s/\<foo\>.*//             # delete “foo” and all following text on the line
:%s/\<foo\>.\{5}//          # delete “foo” and next 5 characters
:noh                        # get rid of highlighting after search
:%s/\s\+$//e                # get rid of trailing whitespace
```

## Buffers

Buffers allow you to open up different sets of files in Vim. See [this resource](https://dockyard.com/blog/2013/10/22/vim-buffers)
```
:edit file          # open a file in a buffer
:ls                 # list all of the buffers
:bad file           # opens file in hidden buffer
^6                  # switches to alternate buffer (listed with # when ls)
:bp                 # switch to previous buffer
:b2                 # switch to buffer #2
:bn                 # switch to next buffer
:bd                 # delete buffer
:ball               # open all buffers
```

### Copying and pasting between buffers

* Start vim and open file1 which is the file you're working on.
* `:e` file2 which will bring up file2 , the file you want to copy lines from.
* locate the lines you want to copy, if it's 3 lines, you hit `3yy`
* `:b1` this will switch to buffer 1, where file1 is
* figure out where you want to insert the lines you yanked, and hit `p`

## Visual Mode

Use `:v` to enter visual mode and `:V` to enter visual mode and select entire
lines. Exit visual mode with <esc><esc>

### Copy and paste

Copying and pasting to the clipboard (so it is available outside of Vim)
* Select using visual mode (`v` or `V`) and type `:w! !pbcopy`
* To copy the whole file `:%w !pbpaste`

Note: It would be good to have a shortcut for this

## Ctags
To start, download ctags (with homebrew or apt). To set it up, in the directory
of the project, run:
```
ctags -R .
```

For some languages, may need some custom set up. In particular, for R 
(this blog post)[http://tinyheero.github.io/2017/05/13/r-vim-ctags.html]
helped. I needed to put the following in `~/.ctags` to make sure it can pick up
R functions:
```
--langdef=R
--langmap=r:.R.r
--regex-R=/^[ \t]*"?([.A-Za-z][.A-Za-z0-9_]*)"?[ \t]*(<-|=)[ \t]function/\1/f,Functions/
--regex-R=/^"?([.A-Za-z][.A-Za-z0-9_]*)"?[ \t]*(<-|=)[ \t][^f][^u][^n][^c][^t][^i][^o][^n]/\1/g,GlobalVars/
--regex-R=/[ \t]"?([.A-Za-z][.A-Za-z0-9_]*)"?[ \t]*(<-|=)[ \t][^f][^u][^n][^c][^t][^i][^o][^n]/\1/v,FunctionVariables/
```
And this in my `~/.vimrc`:
```
let g:tagbar_type_r = {
    \ 'ctagstype' : 'r',
    \ 'kinds'     : [
        \ 'f:Functions',
        \ 'g:GlobalVariables',
        \ 'v:FunctionVariables',
    \ ]
\ }
```
(This post)[https://andrew.stwrt.ca/posts/vim-ctags/] was another good
resource for basic use:
* <C-]> to find the function under the cursor
* <C-t> to get up a level
* :tag <function name> to find a specific function
More commands in the link for generating lists of tags and navigating them.

## Running other programs

```
!python     # runs current file in python
:!bash      # opens bash (^d to go back)
!bash       # runs an open bash script
:w !python  # sends buffer to python w/o writing
,p          # my shortcut for sending buffer to python
:2,7w myfile.txt    # writes lines 2-7 to a file so can run in python
```

## Insert on multiple lines
^V; j the number of times for the number of lines you want to insert on; I;
type what you want; <esc>

## Other
```
u       # undo
r       # redo
```
