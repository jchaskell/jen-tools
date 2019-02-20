# Vim
## Movement
```e        #move to end of word
w       #move forward to beg of word
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
:jumps      #view recent jumps

yy      #yank (copy) current line
5Y      #yank 5 lines
yaw/yiw #yank 
v/V     #visual mode - lets you highlight by word (v) or by line (V) and then yank
p/P     #paste after/before cursors```

## Deletion

## Find and Replace
```
:s/foo/bar/g         #change on current line
:%s/foo/bar/g        #change for whole document
:5,12s/foo/bar/g     #change for lines 5-12
:.,$s/foo/bar/g      #change for current line to last line
:.,+2s/foo/bar/g     #change for current line +2
:g/^bax/s/foo/bar/g    #change for lines starting with baz```

It's also possible to use markers to indicate start/stop
 - need to escape +, ?, |, &, {, ( to use special function; need to escape ., *, \, [, ^, $ to use real character
```
:s/copyright \zs2007\ze All Rights Reserved/2008/     #replaces just the year in that context
```

If you have a cursor on a word, you can press + to search for it then can sub for it with: `:%s//bar/g`
```
:%s/foo/<c-r><c-w>/g        #press control R/W and it fills in word under cursor
:%s/foo/<c-r>a/g or :%s/foo/<c-r>a/=@a/g    #<c-r> adds contents of register a; =@a doesn’t fill in text (helps with a lot of text)
:%s/foo/<c-r>0/g            #replaces w/ contents of last yank command
:%s/.*/zsfoo/bar/           #on each line, replace last “foo”
:%s/\<foo\>.*//             #delete “foo” and all following text on the line
:%s/\<foo\>.\{5}//          #delete “foo” and next 5 characters
:noh                        #get rid of highlighting after search
```

## Other
Undo in command mode
```
u
```
