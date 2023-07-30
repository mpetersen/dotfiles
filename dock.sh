#!/bin/bash
# Setup dock

dockutil --remove all --no-restart

apps=(
  /Applications/iTerm.app
  /Applications/Bitwarden.app
  "/Applications/Microsoft Outlook.app"
  /System/Applications/Mail.app
  /System/Applications/Calendar.app
  "/Applications/IntelliJ IDEA CE.app"
  /Applications/Slack.app
  /System/Applications/Messages.app
  "/Applications/Microsoft Edge.app"
  /Applications/Safari.app
)

for app in "${apps[@]}"; do
  # If link add the linked app
  if [[ -L "$app" ]]; then
    app=$(cd "$app" && realpath .)
  fi
	dockutil --add "$app" --no-restart
done

dockutil --add '/Applications' --view grid --display folder --sort name --no-restart
dockutil --add '~/Downloads' --view grid --display stack --sort dateadded --no-restart
dockutil --add '~' --view grid --display folder --sort kind --no-restart

killall Dock
