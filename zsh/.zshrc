# OMZSH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode auto  # update automatically without asking
plugins=(
  git
  dotenv 
  npm
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


# Android
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator

# Locale settings
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH=$PATH:$HOME/.maestro/bin

# Flutter
export PATH=$PATH:$HOME/Library/flutter/bin

# Git aliases
alias gcb="git checkout -b"
alias gch="git checkout"
alias gp="git fetch -p && git pull"
alias ga="git add -A"
alias gc="git commit -m"

# LG WebOS
# Setting the LG_WEBOS_TV_SDK_HOME variable to the parent directory of CLI
export LG_WEBOS_TV_SDK_HOME="$HOME/work/lg"
if [ -d "$LG_WEBOS_TV_SDK_HOME/CLI/bin" ]; then
  # Setting the WEBOS_CLI_TV variable to the bin directory of CLI
  export WEBOS_CLI_TV="$LG_WEBOS_TV_SDK_HOME/CLI/bin"
  # Adding the bin directory of CLI to the PATH variable
  export PATH="$PATH:$WEBOS_CLI_TV"
fi

# GPG
export GPG_TTY=$(tty)

# Binaries
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

claudeo() {
  export CLAUDE_CODE_SKIP_FAST_MODE_ORG_CHECK=1
  export CLAUDE_CODE_ENABLE_GATEWAY_MODEL_DISCOVERY=1
  export ANTHROPIC_BASE_URL="https://openrouter.ai/api"
  export ANTHROPIC_AUTH_TOKEN="$(op read "op://Private/openrouter/password")"
  export ANTHROPIC_API_KEY=""
  export ANTHROPIC_MODEL="openrouter/free"

  claude "$@"
}

# Opencode
export OPENCODE_ENABLE_EXA=1

# Aliases
alias python=python3
alias vim=nvim

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
