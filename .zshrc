# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="bullet-train"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions autojump brew dirhistory gitfast last-working-dir npm zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# RVM
export RVM_DIR="$HOME/.rvm"
[ -s "$RVM_DIR/scripts/rvm" ] && source "$RVM_DIR/scripts/rvm"

# Android
export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK=$ANDROID_HOME

# jEnv
eval "$(jenv init -)"

#External configurations
source ~/.fluozshrc

# User configuration
alias zshconfig="vi ~/.zshrc"
alias glog="git log --graph --abbrev-commit --decorate --date=relative --all"
alias pnp="gup && gp"