# Don't load global startup files (/etc/z*). Note that /etc/zshenv is still
# loaded.
setopt NO_GLOBAL_RCS

typeset -T MY_NIX_PATH my_nix_path
path=(~/go/bin ~/.cargo/bin $my_nix_path ~/.nix-profile/bin $path)
unset MY_NIX_PATH
