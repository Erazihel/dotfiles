# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="bullet-train"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker-compose zsh-autosuggestions autojump brew gitfast npm zsh-syntax-highlighting you-should-use)

source $ZSH/oh-my-zsh.sh

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM=xterm-256color

# NVM
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

#External configurations
source ~/.externalzshrc

# User configuration
alias zshconfig="nvim ~/.zshrc"
alias gbdr="git fetch -p; git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D"
alias glog="git rev-parse --abbrev-ref HEAD | xargs git log --graph --abbrev-commit --decorate --date=relative --first-parent"
alias pnp="gup && gp"
alias weather="curl wttr.in/paris"
alias vim="nvim"

function gdc() {
	git diff "$1"^ "$1"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/local/etc/profile.d/autojump.sh ]
autoload -U compinit && compinit -u

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

eval "$(starship init zsh)"
