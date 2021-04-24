# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "├─┤${BRANCH}${STAT}"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

function print_chroot {
    if [ -n "$debian_chroot" ]; then
        echo "─┤$debian_chroot├"
    fi
}

export PS1="┌─┤\[\033[31m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[m\]├\`print_chroot\`\[\033[m\]─┤\[\033[34m\]\d \A\[\033[m\]├─┤\[\e[m\]\[\033[35m\]\w\[\033[m\]\`parse_git_branch\`│\n└─\\$ "

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# GOPATH
export GOPATH=$HOME/dev/git/go

# History size
export HISTSIZE=131072000
export HISTFILESIZE=131072000

# History date/time
export HISTTIMEFORMAT='%d/%m/%y %T '

# Go alias to use proxy
# alias go='http_proxy=172.17.0.1:3128 go'
# alias pssh='ssh -o "ProxyCommand /usr/bin/ncat --proxy-type http --proxy 172.17.0.1:3128 %h %p"'

# kitty SSH
alias ssh='TERM=xterm-256color ssh'
