# Don't load global startup files (/etc/z*). Note that /etc/zshenv is still
# loaded.
setopt NO_GLOBAL_RCS

path=(~/go/bin ~/.cargo/bin ~/.nix-profile/bin $path)
