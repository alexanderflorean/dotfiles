
set -U fish_user_paths $fish_user_paths $HOME/.local/bin/
set fish_greeting               # Supresses fish's intro message

set TERM "xterm-256color"
set EDITOR "vim"
set -x NOTES_DIR "~/Dropbox/notes/"
set -U VIRTUALFISH_HOME $HOME/ExtraSpace/python_venvs/

### Aliases ###
# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# Run fish in vim mode
fish_vi_key_bindings


# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"
