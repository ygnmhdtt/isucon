#----------------------------------
# Environment variables
#----------------------------------

export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\$ '
export LESS='-i -M -R -W -q -S'
export EDITOR="vim"
# aws cli
export PATH="$HOME/.local/bin:$PATH"

#----------------------------------
# Alias
#----------------------------------

alias gb='git branch'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gla='git log --graph --all --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit --date=relative'
alias gs='git status'
alias ll='ls -alh'
alias gc='git checkout `git branch | fzf | sed -e "s/\* //g" | awk "{print \$1}"`'
alias gbd='git branch -d `git branch | fzf`'
alias f='cd `find * -type d | grep -v .git | fzf`'
alias v='vi `fzf`'

function grep-fzf-vim { vi `grep -r $1 * | fzf | awk -F: '{print $1}'` }
alias grv='(){grep-fzf-vim $1}'

function git-status-fzf-vim { vi `git status | grep modified | sed "s/^\s\+//" | fzf | awk -F: '{print $2}'` }
alias gsv='git-status-fzf-vim'

#----------------------------------
# fzf
#----------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --border'
