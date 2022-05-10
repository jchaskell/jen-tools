# Most recent update: 1/26/2018

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto -alF'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Aliases
alias ls='ls --color=auto -ACF'
alias ll='ls --color=auto -alF'
alias la='ls -A'
alias l='ls -CF'

# Always copy contents of directories
alias cp='cp -rv'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias grep='grep --color=auto'

# Show contents of directory after moving into it
function cd () {
	builtin cd "$1" # builtin is necessary to override default
	ls
}

alias ga='git add'
alias gb='git branch'
alias gbd='git branch -D'
alias gca='git commit --amend'
alias gcan='git commit --amend --no-edit'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gm='git checkout master'
alias gma='git checkout main'
alias gp='git pull'
alias gd='git diff'
alias gl='git log'
alias gs='git status'
alias gpo='git push origin'
alias grh='git reset --hard'
alias grm='git rebase master'
alias gst='git stash'
alias gcd='git checkout develop'

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Show git branch on prompt
# first sed command finds the row with the star
# second sed command puts () around it
parse_git_branch() {
	 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
 }

function title {
    echo -ne "\033]0;"$*"\007"
}
# whoami is user
# \W is short working directory (http://osxdaily.com/2006/12/11/how-to-customize-your-terminal-prompt/)
# colors are set based on this: http://tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
 export PS1="\$(whoami) \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] 🐱 "

# Source other files
for file in ~/.{extra,aliases}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done

export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
export PATH="/opt/anaconda3/bin/python:$PATH"
export PYTHONPATH="/opt/anaconda3/bin/python"

export PAGER="less -S"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/data/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/data/conda/etc/profile.d/conda.sh" ]; then
        . "/data/conda/etc/profile.d/conda.sh"
    else
        export PATH="/data/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

