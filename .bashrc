# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ]

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*|screen*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# all non-hidden dirs in current directory
alias lsd='ls -d */'
# all dirs in current directory
alias lsda='ls -d */ .*/'
# list all files in current directory
alias lsf='find . -maxdepth 1 -type f -print | cut -c 3- | xargs ls'
alias hid="lsf | grep -e '^\.'"

alias cls='clear; ls'
alias e='exit'
alias lsa='ls -a'

# bashrc
# reload bash config
alias reload='source ~/.bashrc'
alias bashrc='$EDITOR ~/.bashrc'

# Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

export EDITOR=`which vim`
source ~/.git-completion.bash
# export PATH=/path/to/dir:$PATH          <<-- Format for adding to PATH in .bashrc

if [ -d $HOME/pear/bin ]; then
  export PATH=$PATH:$HOME/pear/bin
fi

if [ -d $HOME/android-sdks ]; then
  export PATH=$PATH:$HOME/android-sdks/tools
  export PATH=$PATH:$HOME/android-sdks/platform-tools
fi

export TERM=xterm

# irc
export IRCNICK=luke-gru
export IRCNAME=lukeDOTgruATgmail
export IRCRC="$HOME/.ircrc"

# aliases
alias lampp='sudo /opt/lampp/lampp'

# vim stuff
# for use after ack list search:
alias vimp='vim $(!!)'
# good ol gv, good in terminal and good in vim!
alias gv='gvim --remote-silent'
alias vimpack='vim $(!! -l)'
alias vimrc='$EDITOR ~/.vimrc'

# rvm
alias gemset='rvm gemset name'
alias gemsets='rvm gemset list'
alias gems='gem list'
alias rubies='rvm list'

# tmux
# start tmux with 256 colors
alias tmux="tmux -2"

# ack-grep
alias ack='ack-grep'

# copy/paste to/from clipboard
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# git
alias gdiff='git diff | gvim --remote-silent'
alias g='git'
# change the rebasing defaults
alias alwaysrebase='git config branch.autosetuprebase always'
alias localrebase='git config branch.autosetuprebase local'
alias neverrebase='git config branch.autosetuprebase never'

# sysadmin type stuff
# list processes in terms of cpu %
alias pcpu='ps -e -o pcpu,cpu,nice,state,cputime,args --sort pcpu | sed "/^ 0.0 /d"'
# list processes in a tree hierarchy
alias phier='ps -e -o pid,args --forest'
alias ip="ifconfig | grep -Eo 'inet addr:192\.[^ ]+' | grep -Eo [0-9.]+"

# /aliases

# rvm prompt
PS1="(\$(~/.rvm/bin/rvm-prompt v g))$PS1"
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion
[[ -s "/home/luke/.rvm/scripts/rvm" ]] && source "/home/luke/.rvm/scripts/rvm"

export LESS=-RFX

if [ -e $HOME/allmine ]
then
  source "$HOME/allmine"
fi

if [ -e $HOME/.xmodmap ]
then
  xmodmap "$HOME/.xmodmap"
fi

if [ -d $HOME/bin ]
then
  export PATH=$HOME/bin:$PATH
fi

# not sure why this isn't working when I set the default, but here it goes
rvm gemset use rails3.1.0
export JAVA_HOME="/usr/lib/jvm/java-6-sun-1.6.0.26/bin"
alias rhodes='rvm use 1.8.7@rhodes'
alias traf="cd $HOME/workspace/traffic"
alias trafm="cd $HOME/workspace/trafficmanager"
alias trafr="cd $HOME/Desktop/code/cophenetic/streetsmart"
