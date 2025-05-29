# .bash_profile

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
	export MOZ_ENABLE_WAYLAND=1
fi

if [[ "${XDG_CURRENT_DESKTOP,,}" == "kde" || "${DESKTOP_SESSION,,}" == "plasma" ]]; then
  export QT_QPA_PLATFORMTHEME=" "
fi

