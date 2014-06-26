# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
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

## git completion?
if [ `which git` != "" ]; then
    [[ -e $HOME/.git-completion.bash ]] && source $HOME/.git-completion.bash
    [[ -e $HOME/.git-prompt.sh ]] && source $HOME/.git-prompt.sh
    [[ -e $HOME/dotfiles/git-completion.bash ]] && source $HOME/dotfiles/git-completion.bash
    [[ -e $HOME/dotfiles/git-prompt.sh ]] && source $HOME/dotfiles/git-prompt.sh
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 " (%s)")\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (%s)")\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

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

if [ -f ~/.profile ]; then
  . ~/.profile
fi

#################### begin my stuff ##########################

#for node.js
if [[ -d ~/node_modules/.bin ]]; then
  PATH=$PATH":~/node_modules/.bin"
fi

#detect OS:
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
  alias ls="ls --color=auto"
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='darwin'
  alias ls="ls -G"
fi

# vim
export EDITOR=vim

## for knife
alias knife_ssh="knife ssh -a cloud.public_hostname -x ubuntu -i ~/.ssh/chef_rsa -V"
alias knife_cb="knife cookbook"

alias sshss="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
alias scpss="scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

chef-node-host () {
  eval 'knife-ssh "role:*" "cat /etc/chef/first-boot.json" | sed "s/{\"run_list\":\[\"role//g" | sed "s/\"\]}//g" ';
}
knife-env() {
  eval 'knife environment $*';
}
tree() {
  eval "ls -R $*| grep ':$' | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/  /' -e 's/-/|/'"
}

make-n-pip() {
    eval 'virtualenv .'
    eval '. bin/activate'
    eval 'pip install -r ./requirements.txt'
}

alias makepass="pwgen -C -n -y -s -B -1 $1"

# ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

### Add go path
PATH="/usr/local/go/bin:/usr/local/go:$PATH"

### Add packer to path
PATH="/usr/local/packer:$PATH"

### Added by the Heroku Toolbelt
PATH="/usr/local/heroku/bin:$PATH"

### Brew
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# ChefDK
PATH="/opt/chefdk/bin:$PATH"

export PATH

if [[ `which rbenv` != "" ]]; then
    eval "$(rbenv init -)"
fi
