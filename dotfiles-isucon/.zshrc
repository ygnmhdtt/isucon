#----------------------------------
# Environment variables
#----------------------------------

# for less options
export LESS='-i -M -R -W -q -S'

# golang
export PATH=$PATH:/home/isucon/local/go/bin
export GOROOT=/home/isucon/local/go
export GOPATH=`go env GOPATH`
export PATH=$PATH:$GOPATH/bin
export PATH=$HOME/local/go/bin:$HOME/go/bin:$PATH

# default editor
export EDITOR="vim"

#----------------------------------
# aliases
#----------------------------------

# ----------------
# common
# ----------------

alias ll='ls -alh'
alias t='tig'
alias vi='vim'

# ----------------
# git
# ----------------

# alias gb='git branch'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gla='git log --graph --all --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gs='git status'

# ----------------
# fzf
# ----------------

alias gc='git checkout `git branch | fzf | sed -e "s/\* //g" | awk "{print \$1}"`'

function grep-fzf-vim { vi `grep -r $1 * | fzf | awk -F: '{print $1}'` }
alias gf='(){grep-fzf-vim $1}'

function git-status-fzf-vim { vi `git status | grep modified | sed "s/^\s\+//" | fzf | awk -F: '{print $2}'` }
alias gsv='git-status-fzf-vim'

alias gbd='git branch | fzf | xargs git branch -d'

#----------------------------------
# Appearance
#----------------------------------

# enable colors
autoload -Uz colors
colors

# git prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{241}%b %c%u%f"
zstyle ':vcs_info:*' actionformats '%b|%a'
precmd () { vcs_info }

PROMPT='
'
PROMPT=$PROMPT'%F{038}%~%f '
PROMPT=$PROMPT'${vcs_info_msg_0_}'
PROMPT=$PROMPT'
%F{165}❯%f '

#----------------------------------
# fzf
#----------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --border'

#----------------------------------
# Keybind
#----------------------------------

bindkey -e

#----------------------------------
# Auto completion
#----------------------------------

# enable autoload
autoload -Uz compinit
compinit -u
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..

#----------------------------------
# zsh
#----------------------------------

# settings for history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
# no beep
setopt no_beep
# disable flow control
setopt no_flow_control
# must input 'logout' when logout
setopt ignore_eof
# '#' for comment
setopt interactive_comments
# don't need `cd` when move into directory
setopt auto_cd
# do pushd automatically
setopt auto_pushd
# duplicate directory will not be `pushd`
setopt pushd_ignore_dups
# share history in all shell
setopt share_history
# don't store same command to history
setopt hist_ignore_all_dups
# don't store command that starts with space
setopt hist_ignore_space
# remove space when store history
setopt hist_reduce_blanks
# ignore meta character
setopt nonomatch
# `history` will not be stored at zsh_history
setopt hist_no_store
# wildcard
setopt extended_glob
# vim:set ft=zsh:
# enable japanese
setopt print_eight_bit
