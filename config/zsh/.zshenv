# Enable Git/VCS prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

PROMPT='%F{blue}[%T/%?/Xs'\$vcs_info_msg_0_' %~]%f'$'\n$ '
