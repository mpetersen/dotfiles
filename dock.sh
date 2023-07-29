#!/bin/bash
# Setup dock

dockutil --remove all --no-restart

apps=(
  /Applications/iTerm.app
  /Applications/Bitwarden.app
  /System/Applications/Mail.app
  /System/Applications/Messages.app
  /System/Applications/Calendar.app
  /System/Cryptexes/App/System/Applications/Safari.app
)

for app in "${apps[@]}"; do
	dockutil --add "$app" --no-restart
done

dockutil --add '/Applications' --view grid --display folder --sort name --no-restart
dockutil --add '~/Downloads' --view grid --display stack --sort dateadded --no-restart
dockutil --add '~' --view grid --display folder --sort kind --no-restart

killall Dock
