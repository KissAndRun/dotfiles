# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


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
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#zinit wait lucid for \
  #atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    #zdharma/fast-syntax-highlighting \
  #atload"zpcdreplay" wait"1" \
    #OMZP::kubectl \
  #blockf \
    #zsh-users/zsh-completions \
  #atload"!_zsh_autosuggest_start" \
    #zsh-users/zsh-autosuggestions \
  #as"completion" is-snippet \
    #https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
    #https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma/fast-syntax-highlighting

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# 补全
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
#zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/theme-and-appearance.zsh
#zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
#zinit snippet OMZ::plugins/git-flow/git-flow.plugin.zsh
#zinit snippet OMZ::plugins/autojump/autojump.plugin.zsh
#zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh
#zinit snippet OMZ::plugins/tmuxinator/tmuxinator.plugin.zsh
zinit snippet OMZ::plugins/command-not-found/command-not-found.plugin.zsh
#zinit snippet OMZ::plugins/pip/pip.plugin.zsh
#zinit snippet OMZ::plugins/fzf/fzf.plugin.zsh

#zinit ice lucid wait='1'
#zinit snippet OMZ::plugins/git/git.plugin.zsh

# Gitignore plugin – commands gii and gi
#zinit ice wait"2" lucid
#zinit load voronkovich/gitignore.plugin.zsh

#zinit ice lucid wait='0'
#zinit light djui/alias-tips

# PATH
export PATH="/home/$USER/node/bin:$PATH"
export PATH="/home/$USER/.local/bin:$PATH"
export PATH="/home/$USER/texlive/bin/x86_64-linux:$PATH"
export PATH="/home/$USER/.linuxbrew/bin:$PATH"
 
# alias
alias zshconfig="vim ~/.zshrc"
alias i3config="vim ~/dotfiles/.i3/config"
alias vimconfig="vim ~/dotfiles/.vimrc"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fd=fdfind
alias ll='ls -alF'
alias la='ls -A'
alias vim=nvim
set bell-style none
alias wcd="cd /mnt/c/Users/Run/"
alias clang++="clang++ -std=c++11"
#alias brew="/home/$USER/.linuxbrew/bin/brew"

export LANG="zh_CN.UTF-8"
export LANGUAGE="zh_CN:zh"
#export DISPLAY=localhost:0
#export XDG_RUNTIME_DIR=/home/$USER/.cache/xdg_runtime

###
###FZF
###
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='fdfind --hidden --follow -E ".git" -E "node_modules" . /etc /home'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"

# use fzf in bash and zsh
# Use ~~ as the trigger sequence instead of the default **
#export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
#export FZF_COMPLETION_OPTS=''

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fdfind --hidden --follow -E ".git" -E "node_modules" . /etc /home
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fdfind --type d --hidden --follow -E ".git" -E "node_modules" . /etc /home
}

####  bindkey

bindkey '^W' forward-word
