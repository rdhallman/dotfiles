# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# -----

#alias ls=exa


# HSTR configuration | brew install hstr #################################
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey -s "\C-r" "\C-a hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)

# zsh-history-substring-search key bindings #############################
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit for \
    light-mode zinit-zsh/z-a-rust \
    light-mode zinit-zsh/z-a-as-monitor \
    light-mode zinit-zsh/z-a-patch-dl \
    light-mode zinit-zsh/z-a-bin-gem-node \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zdharma/fast-syntax-highlighting \
    light-mode zdharma/history-search-multi-word \

# Binary release in archive, from GitHub-releases page.
# After automatic unpacking it provides program "fzf".
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf-bin

# powerlevel10k
zinit ice depth=1;
zinit light romkatv/powerlevel10k

ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BEAM

ZVM_KEYTIMEOUT=0
ZVM_ESCAPE_KEYTIMEOUT=0

### End of Zinit's installer chunk

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/p10k/${TERM_PROGRAM}.zsh ]] || source ~/.config/p10k/${TERM_PROGRAM}.zsh

#echo "LOGIN SHELL:" $(echo $(ls -l $SHELL) | cut -d'>' -f2)
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
#

## ZSH Functions

function srccp() {
  #rsync -aP --exclude .git --exclude dist --exclude .yarn/cache $1/ $2
  rsync -aP --exclude .git --exclude dist $1/ $2
}

# VIM Stuff
alias vim=lvim

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh


# NVM/N Node Version Loader

load-nvmrc() {
  local nvmrc_path="$(pwd -P)/.nvmrc"

  if [[ -a "$nvmrc_path" ]]; then
    local nvmrc_node_version=$(cat "${nvmrc_path}")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      n latest
    elif [ "$nvmrc_node_version" != "$current_node_version" ]; then
      n $nvmrc_node_version
    fi
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

#export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
#export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/.local/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


export VULTR_API_KEY="J4H6RQX2BQCIZNGJCJ23T6YMDZ7U6O4NIOCQ"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export TF_VAR_devops_automation_token=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

# enable VI Mode
bindkey -v
