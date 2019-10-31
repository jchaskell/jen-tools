# Bash
## Find files
```
find . -name 'filename'
```

* `mindepth` and `maxdepth` options refer to directory depth
* Find just files (not directories): `find "hello.txt" -type f`

## GREP
Filters a file line by line against a pattern: `grep <pattern> <file>`
Example: `echo '$line' | grep <pattern>`

Flags:
* -v    inverts match
* -r    interprets pattern as literal string
* -H/-h print (or don't print) matched filename
* -i    case insensitive
* -l    prints names of files that match instead
* -n    prints line number
* -w    forces the pattern to match an entire word
* -x    forces patterns to match the whole line

Search only in a certain type of file: `grep -r --include=*.R "search regex"`

Print out lines before and after:
```
grep -A 10 "hello" # also prints 10 lines after each "hello"
grep -B 5 "hello" # also prints 5 lines before each "hellow"
```

Limit results returned from grep (e.g. to first 5 results): `grep -m 5 "hello"`

Turning on colors with grep is really awesome until it's not. It changes the
output unless you pipe to another command or save to a file. This caused me
a lot of pain. See
[this](https://linuxcommando.blogspot.com/2007/10/grep-with-color-output.html).

### Flags

`-l` just prints the names of files
`--include`/`--include-dir`/`--exclude`/`--exclude-dir` lets you add patterns
for inclusion or exclusion of specific files or directories

## Various Commands

* control-r - reverse search
* control-a - jump to beginning of line
* control-e - jump to end of line
* control-u - clears from cursor to beginning of the line
* control-l - clear
* control-d - exit
* !!        - repeat previous command
* !curl     - run the last  command that started with "curl"
* wc <file> - word count - gives you lines, words, bytes
* ping      - pings a server to see if it's working
* ps        - list all processes
* kill -9 <PID> - kill process
* Look at a process id: `ps aux | grep pid`
* Look at MY processes: `ps aux | grep uname`
* Defining variables: `var=hello`
* Displaying variables: `echo $var` (note: echo var will return 'bar', not
    'hello')
* Concatenating variables: path="${HOME_DIR}/files"
* `^[A]^[B]` takes previous command and replaces A with B
* `cat > <file-name>` lets you type in file (control-d to leave)
* `cat <file-name> | nl` prints line numbers
* cd _      - goes to previous directory
* ~/.script.sh  run an executable script
* `chmod 755 <scriptname>` makes a file executable on a Mac

## cp
Flags helpful when copying directories:
* -a    preserve special attributes such as ownership, timestamps, etc
* -v    verbose output
* -r    copy directories recursively

## cut
Cut based on line numbers: `cut -c 1 doc.txt` (cuts first column)
Cut based on fields: `cut -f 1 doc.txt` (cuts first field)

## SED

Used for substitution - similar to substitution in vim: `s/ / /g`

Syntax: `"hello" | sed "s/l/\*/g"`

Capture groups behave normally: `s/([A-Z])(a-z)+/\1/g`
You can make things upper/lower case in the replace clause really easily:
`s/(^|_)/([a-z])/\U\2/g`

Flags: note - flags (and general functionality) is very different in the Mac
version of sed. Download the GNU version!
* r - for regex extended
* i - edit files in place 

When using SED's substitution, you need to escape some characters. But what if
you want to take the keyword from variable input? Use this to add escapes
(taken from
(here)[https://stackoverflow.com/questions/407523/escape-a-string-for-a-sed-replace-pattern]):
```
sed -e 's/[]\/$*.^[]/\\&/g'
```

## awk

Add up a set of values from one field in a file
`cut -f 2 log.txt | awk '{total = total + $1}END{print total}'`

## Shell scripting

Variables:
`VAR=''`
Use `$VAR` to refer to variables and `"$VAR"` to get shell to expand the
variable name and preserve whitespace i.e. `echo "path/to/"$VAR""`


If / then sequence generally used:
```
if [ $# -ne 1 ]; then
    echo "ERROR"
    exit 1
fi
```
Use `if [   ] || [   ]` for or

Though
```
if <commands1>
then
    <commands2>
else 
    <commands3>
fi
```
also works. Using `[]` means it is a traditional shell `test` command that
returns an exit code. `[[]]` is from ksh but works on other shells as well.

[The first answer
here](https://unix.stackexchange.com/questions/306111/what-is-the-difference-between-the-bash-operators-vs-vs-vs) has a good explanation

`$` denotes command line arguments; `$1` gives you the first one (that's not
the script); `$#` gives you the count
`ne` is `!=`

CD into the directory of the file that's being run: `cd "$(dirname "$0")"`
`dirname` gives you the directory of the file path you give it

To test if a directory exists (or doesn't exist):
```
if [ -d "$DIRECTORY" ]; then

fi

if [ -d "$DIRECTORY" ]; then

fi
```

Test if a file exists: `if [[ -f "$file" ]]`

Current working directory is environmental variable `$PWD`. If you want to just
get the last folder: `"${PWD##*/}"`. For more on parameter expansion, see (this)[https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html]

*Diff* gives you the difference in the output of two commands. For example:
```
```

## SCP
Let's you move files to and from remote hosts.

Note: both of these are run locally
```
# From local to remote
scp <local-file> <remote>:<remote-file-path>

# From remote to local
scp <remote>:<remote-file-path> <local-file-path>

# SCP an entire folder
scp -r <from-path> <to-path>
```

Flags
`-r`    recursively copy files
`-p`    preserve modification/access times from original file

## Actions on Multiple Files
### Find and Replace Across Multiple Files
I wanted to find and replace a value across multiple files that had the same name but were in different directors (this solution will also work for files that don't have the same name but have the same file extension or similar names, etc). However, it was not quite a simple find and replace because, let's say, all files had a line that started with `packages:`, and I need the line to actually read `packages: Spark`. Some files did have the "Spark" appended but some did not.

To do so, the bash command is:
```
find . -name 'file.name' | xargs sed -i -E 's/packages:( Spark)?/packages: Spark/g'
```
Find finds files with the given name. Xargs executes the next command from standard input (need to read more on this). Sed does find and replace. The `-E` flag allows for using extended regular expressions, while the `-i` flag allows for find and replace in place.

On OSX, this needs to look a little different because the `sed` command requires an extension with which to add to the files. If you do not want to give the files a new extension and just want to edit them in place, you can provide an empty set of quotes:
```
find . -name 'file.name' | xargs sed -i '' -E 's/packages:( Spark)?/packages: Spark/g'
```
 
For more information on sed, see this [man page](https://www.gnu.org/software/sed/manual/sed.html).

### Delete Multiple Files
Deletes all files with the ".pyc" extension.
```
find . -name '*.pyc' -delete
```

## AWS S3
* AWS list files: `aws s3 ls <bucket>`
* Copy files (either locally to AWS or within AWS): `aws s3 cp <file-name>`
- add `--recursive` if necessary; may also need to add `--sse`
* Look at the head of a file: `aws s3 cp <file> - | head`
* A better way to copy everything recursively: `aws s3 sync <source-path>
    <destination-path>`

## Tmux
### Really basic commands
```
# New named session
tmux new -s name

# Attach to an existing session
tmux a -t name

# List sessions
tmux ls

# Kill session
tmux kill-session -t name

# Display tmux session name
tmux display-message -p '#S'
``` 
Windows - all require your prefix before the command (the default is `ctrl+b`)
```
c   # create window
w   # list windows
n   # next window
p   # previous window
&   # kill window
```

Swap panes: prefix + {/}
Make pane full window & back again: prefix + z
Kill entire session: prefix + kill

Two people can attach to the same session [see
here](ttps://www.hamvocke.com/blog/remote-pair-programming-with-tmux/)
