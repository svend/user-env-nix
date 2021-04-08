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

# TODO: Can this work with native-shell-complete?
# # Disable echo inside EMACS
# if [[ -v INSIDE_EMACS ]]; then
#   unsetopt zle
#   stty -echo
# fi

# Enable completion system
autoload -Uz compinit
compinit

# Enable Git/VCS prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

PROMPT='%F{blue}[%T/%?/Xs'\$vcs_info_msg_0_' %~]%f'$'\n$ '

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
setopt PROMPT_SUBST
PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
