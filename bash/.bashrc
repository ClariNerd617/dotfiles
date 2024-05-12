# Ensures tmux is running
if [ "$TMUX" = "" ]; then tmux; fi
# Check if the shell is interactive
case $- in
*i*)
	# If interactive, do nothing and continue
	;;
*)
	# If not interactive, exit the .bashrc to prevent further execution
	return
	;;
esac

export OSH='/home/henry/.oh-my-bash'

OSH_THEME="powerline-icon"

export UPDATE_OSH_DAYS=13

ENABLE_CORRECTION="true"

HIST_STAMPS='yyyy-mm-dd'

OMB_USE_SUDO=true

OMB_PROMPT_SHOW_PYTHON_VENV=true # enable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
completions=(
	git
	composer
	ssh
	nvm
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
aliases=(
	general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
plugins=(
	git
	bashmarks
	golang
	kubectl
	npm
	sudo
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

alias ls='exa --group-directories-first'
alias ll='ls -lh'
alias la='ls -a'
alias l='ll -a'
alias cat='batcat'
eval "$(zoxide init bash)"
alias nvim='/opt/nvim-linux64/bin/nvim' # This ensures the correct version of nvim is used
alias cd='z'
alias lzg='lazygit'
alias pc='podman-compose'
alias p='podman'
alias k='kubectl'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
export DENO_INSTALL="/home/henry/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
