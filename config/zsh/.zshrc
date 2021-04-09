# Aliases
alias cd-git='cd "$(git rev-parse --show-toplevel)"'
alias e='emacsclient --no-wait'
alias git='TERM=eterm-color git'
alias kc='kubectl config current-context'
alias kn='kubectl get nodes -o jsonpath='\''{range .items[*]}{.metadata.name}{"\n"}{end}'\'''
alias kg='kubectl get -o jsonpath='\''{range .items[*]}{.metadata.name}{"\n"}{end}'\'''
alias kcs='kubectl config view -o jsonpath='\''{range .contexts[*]}{.name}{"\n"}{end}'\'''
alias kuc='kubectl config use-context'
alias kubectl='TZ=UTC kubectl'
alias rg='rg --color always --smart-case'
alias ssh-p='ssh -o PasswordAuthentication=yes -o PubkeyAuthentication=no -o ControlPath=none'
alias ssh-m='ssh -o ControlPath=none'
alias tree='tree -I .git'

# Options
setopt NOFLOWCONTROL # disable flow control (ctrl-s stop, ctrl-q continue)

# Enable completion system

# Homebrew (https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh)
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# Nix (TODO)

autoload -Uz compinit
compinit

source <(kubectl completion zsh 2>/dev/null)

# zsh backwards delete word deletes past slashes. I prefer Bash's behavior of stopping at /.
autoload -U select-word-style
select-word-style bash

# Enable Git/VCS prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
# Show uncommitted changes
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats " %s:%b:%u%c"
setopt PROMPT_SUBST

# Measure command duration (sets _LAST_DURATION)
prompt_duration_start() { _LAST_SECONDS=$SECONDS }
prompt_duration() {
  if [[ -v _LAST_SECONDS ]]; then
    _LAST_DURATION=$((SECONDS - _LAST_SECONDS))
    unset _LAST_SECONDS
  else
    _LAST_DURATION=0
  fi
}
preexec_functions+=(prompt_duration_start)
precmd_functions+=(prompt_duration)

PROMPT='%F{blue}[%T/%?/'\${_LAST_DURATION}'s'\$vcs_info_msg_0_' %~]%f'$'\n$ '

# Emacs vterm

vterm_printf() {
  if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
    # Tell tmux to pass the escape sequences through
    printf "\ePtmux;\e\e]%s\007\e\\" "$1"
  elif [ "${TERM%%-*}" = "screen" ]; then
    # GNU screen (screen, screen-256color, screen-256color-bce)
    printf "\eP\e]%s\007\e\\" "$1"
  else
    printf "\e]%s\e\\" "$1"
  fi
}

vterm_prompt_end() {
  vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}
if [[ "$INSIDE_EMACS" == "vterm" ]]; then
  PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
fi

# ZDOTDIR is set to a read-only location, set HISTFILE
# This doesn't work from .zshenv
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
