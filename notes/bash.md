# Bash
## Find files
```
find . -name 'filename'
```
## SCP
Let's you move files to and from remote hosts.

Note: both of these are run locally
```
# From local to remote
scp <local-file> <remote>:<remote-file-path>

# From remote to local
scp <remote>:<remote-file-path> <local-file-path>
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
``` 
Windows - all require your prefix before the command (the default is `ctrl+b`)
```
c   # create window
w   # list windows
n   # next window
p   # previous window
&   # kill window
```
