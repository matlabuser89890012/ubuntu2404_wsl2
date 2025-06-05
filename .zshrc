# Path to your oh-my-zsh installation (if using it)
export ZSH="$HOME/.oh-my-zsh"

# Check if zsh is available, if not provide instructions
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Please install it with: sudo apt install zsh"
    echo "After installation, set zsh as your default shell: chsh -s $(which zsh)"
    return 1 2>/dev/null || exit 1
fi

# Check if Oh My Zsh is installed
if [ -d "$ZSH" ]; then
    # Set name of the theme to load
    ZSH_THEME="robbyrussell"

    # Enable plugins for data science/Python development
    plugins=(
        git
        zsh-autosuggestions
        zsh-syntax-highlighting
        python
        pip
        virtualenv
        conda-zsh-completion
        docker
        docker-compose
        jsontools
    )

    # Load Oh My Zsh
    if [ -f "$ZSH/oh-my-zsh.sh" ]; then
        source $ZSH/oh-my-zsh.sh
    else
        echo "Oh My Zsh framework not found. Install with:"
        echo "sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
    fi
else
    # Standalone configuration without Oh My Zsh
    echo "Oh My Zsh not found. Using basic zsh configuration..."
    
    # Basic command history configuration
    HISTSIZE=10000
    SAVEHIST=10000
    HISTFILE=~/.zsh_history
    setopt appendhistory
    setopt share_history
    setopt hist_ignore_all_dups
    
    # Basic completion system
    autoload -Uz compinit && compinit
    zstyle ':completion:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
fi

# Set default editor
export EDITOR='nano'

# Python/Data Science specific configurations
# ---------------------------------------------

# Ensure compatibility with Python/Data Science workflows
alias py='python'
alias ipy='ipython'
alias jn='jupyter notebook'
alias jl='jupyter lab'
alias ca='conda activate'
alias cda='conda deactivate'
alias pipi='pip install'
alias pipie='pip install -e .'
alias pipir='pip install -r requirements.txt'

# Add custom paths
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Automatically activate conda environments with directory switching
if [ -n "$ZSH_VERSION" ]; then
    chpwd_functions=(${chpwd_functions[@]} "auto_conda")
fi

auto_conda() {
    if [ -e "environment.yml" ]; then
        ENV_NAME=$(grep "name: " environment.yml | sed 's/name: //')
        if [ -n "$ENV_NAME" ] && [ "$CONDA_DEFAULT_ENV" != "$ENV_NAME" ]; then
            echo "Found environment.yml with environment $ENV_NAME. Activating..."
            conda activate "$ENV_NAME"
        fi
    fi
}

# Custom function to create a new data science project structure
newdsproject() {
    if [ -z "$1" ]; then
        echo "Please provide a project name."
        return 1
    fi
    
    mkdir -p "$1"/{data/{raw,processed,external},notebooks,src/{data,features,models,visualization},docs,results}
    touch "$1/README.md"
    touch "$1/requirements.txt"
    
    echo "# $1" > "$1/README.md"
    echo "Data science project structure created at $1/"
}

