# Common aliases for both bash and zsh

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Git shortcuts
alias gs='git status'
alias gp='git pull'
alias gc='git commit'
alias ga='git add'
alias gd='git diff'

# System updates and package management
alias update='sudo apt update && sudo apt upgrade -y'
alias install='sudo apt install -y'
alias remove='sudo apt remove -y'

# Miscellaneous
alias c='clear'
alias h='history'
alias myip='curl http://ipinfo.io/ip'

# Python/Data Science specific aliases
alias py='python'
alias ipy='ipython'
alias jn='jupyter notebook'
alias jl='jupyter lab'
alias ca='conda activate'
alias cda='conda deactivate'
