# .bash_profile

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	export MOZ_ENABLE_WAYLAND=1
fi

if [ -f ~/.cargo/env ]; then
  . "$HOME/.cargo/env"
fi

if [[ "${XDG_CURRENT_DESKTOP,,}" == "kde" || "${DESKTOP_SESSION,,}" == "plasma" ]]; then
  QT_QPA_PLATFORMTHEME=" "
fi

if [ -e /home/henrique/.nix-profile/etc/profile.d/nix.sh ]; then . /home/henrique/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "/home/henrique/.deno/env"