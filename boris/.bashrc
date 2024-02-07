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

function print_nix_shell {
    if [ -n "$IN_NIX_SHELL" ]; then
        echo "─┤$IN_NIX_SHELL├"
    fi
}

function __transfer {
    if [ $# -eq 0 ]; then
        echo "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2
        return 1
    fi
    local url="$1"
    if tty -s; then
        local file="$2"
        local file_name=$(basename "$file")
        if [ ! -e "$file" ]; then
            echo "$file: No such file or directory">&2
            return 1
        fi
        if [ -d "$file" ]; then
            local file_name="$file_name.zip"
            (pushd "${file}" && zip -r -q - .) |\
                curl -w "\n" --progress-bar --upload-file "-" "${url}/$file_name" |\
                tee /dev/null
        else
            cat "$file" |\
                curl -w "\n" --progress-bar --upload-file "-" "${url}/$file_name" |\
                tee /dev/null
        fi
    else
        local file_name=$1
        curl -w "\n" --progress-bar --upload-file "-" "${url}/$file_name" |\
        tee /dev/null
    fi
}

gdbd() {
    local id="$(tmux split-pane -hPF "#D" "tail -f /dev/null")"
    tmux last-pane
    local tty="$(tmux display-message -p -t "$id" '#{pane_tty}')"
    gdb-dashboard -ex "dashboard -output $tty" "$@"
    tmux kill-pane -t "$id"
}

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
export PS1="┌─┤\[\033[31m\]\u\[\033[m\]@\[\033[31m\]\h\[\033[m\]├\`print_chroot\`\`print_nix_shell\`\[\033[m\]─┤\[\033[34m\]\d \A\[\033[m\]├─┤\[\e[m\]\[\033[35m\]\w\[\033[m\]\`parse_git_branch\`│\n└─\\$ "
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=131072000
export HISTFILESIZE=131072000

# History date/time
export HISTTIMEFORMAT='%d/%m/%y %T '

# Go alias to use proxy
# alias go='http_proxy=172.17.0.1:3128 go'
# alias pssh='ssh -o "ProxyCommand /usr/bin/ncat --proxy-type http --proxy 172.17.0.1:3128 %h %p"'

# kitty SSH
alias ssh='TERM=xterm-256color ssh'

# rsync
alias cpv='rsync -vhae ssh --progress'

# transfer
alias transfer='__transfer "https://transfer.sh"'
alias transfer_bk='__transfer "https://t.bk.ru"'
