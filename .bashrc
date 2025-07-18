export DEBEMAIL="adopcarry@gmail.com"
export DEBFULLNAME="Bo-Jun Huang"

# mc related
if [ -f /usr/lib/mc/mc.sh ]; then
    . /usr/lib/mc/mc.sh
fi

# quilt related
if [ -f /usr/share/bash-completion/completions/quilt ]; then
    alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
    . /usr/share/bash-completion/completions/quilt
    complete -F _quilt_completion $_quilt_complete_opt dquilt
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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# for bash-completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

platform='unknown'
unamestr=$(uname)
if [ "$unamestr" = 'Linux' ]; then
    platform='linux'
elif [ "$unamestr" = 'FreeBSD' ]; then
    platform='freebsd'
fi

if [ "$platform" = 'freebsd' ]; then
    alias ls='ls -G'
elif [ "$platform" = 'linux' ]; then
    alias ls='ls --color=auto'
fi
alias sdocker='sudo docker --config=/root/.docker'
alias grep='grep --color=auto'
