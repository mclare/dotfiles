force_color_prompt=yes
PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '


# some useful aliases
alias h='fc -l'
alias df="df -h"
alias starwars="telnet towel.blinkenlights.nl"
alias utime='php -r print time(); php -r print "\n";'
alias please="sudo"

# be paranoid
alias cp='cp -ip'
alias mv='mv -i'
alias rm='rm -i'
alias crontab='crontab -i'

# I like my nano!
export EDITOR='nano'
#export VISUAL="nano -w"
alias nano='nano -wc'
alias pico='nano -wc'


# List the most recent files in a directory
lsnew()
{
	ls -lt ${1+"$@"} | head -20;
}

#Reminder about how I like to encrypt things
cryptscript () {
echo 'Encrypted archive with openssl and tar
tar -zc folder_to_encrypt | openssl enc -aes-256-cbc -e > secret.tar.gz.enc
command to decrypt:
openssl enc -aes-256-cbc -d < secret.tar.enc | tar -zx'
} 

crypt-tar-in () {
	tar zc $1 | openssl enc -aes-256-cbc -e > $2.tar.crypt
}

crypt-tar-out () {
		openssl enc -aes-256-cbc -d < $1 | tar xz
}

export common_key='b89a4ffe9bdca2d9ed1eb0ed3684e289'

quick-crypt-tar-in () {
	tar zc $1 | openssl enc -aes-256-cbc -pass pass:$common_key -e > $1.tar.crypt
}
quick-crypt-tar-out () {
		openssl enc -aes-256-cbc  -pass pass:$common_key  -d < $1 | tar xz
}

crypt-des-in () {
	if [ -f $1 ] ; then
		openssl des3 -salt -in $1 -out $1.des3
    else
        echo "'$1' is not a valid file"
    fi
}

crypt-des-out () {
	if [ -f $1 ] ; then
		openssl des3 -d -salt -in $1 -out $2
    else
        echo "'$1' '$2' are not a valid files"
    fi
}


# More Aliases

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # macOS `ls`
	colorflag="-G"
fi

# List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Recursively delete `.DS_Store` files
# Show/hide hidden files in Finder
alias findershowall="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# OSX Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 7'"

# OSX Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"


### ---------
### Functions
### ---------

# Erase duplicates
export HISTCONTROL=erasedups
# resize history size

# User specific environment and startup programs
PATH=$PATH:$HOME/bin

export PATH


eval $(thefuck --alias)

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi



# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
