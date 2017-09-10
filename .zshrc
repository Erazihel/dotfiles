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

# Yarn
export PATH="$HOME/.yarn/bin:$PATH"

# VSCode
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Start GPG Agent
eval $(gpg-agent --daemon)
eval $(gpg-agent --default-cache-ttl 3600)

# Start SSH Agent
eval `ssh-agent -s`
eval `ssh-add ~/.ssh/id_rsa`

#External configurations
source ~/.fluozshrc

# User configuration
alias zshconfig="vim ~/.zshrc"
alias glog="git log --graph --abbrev-commit --decorate --date=relative --all"
alias pnp="gup && gp"
alias weather="curl wttr.in/paris"
alias tf="terraform"
alias tg="terragrunt"
alias vim="nvim"

function gdc() {
	git diff "$1"^ "$1"
}
