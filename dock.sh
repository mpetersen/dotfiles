#!/bin/bash
# Setup dock

dockutil --remove all --no-restart

apps=(
	"/System/Applications/Utilities/Console.app"
	"/Applications/iTerm.app"
	"/System/Applications/Contacts.app"
	"/System/Applications/Mail.app"
	"/System/Applications/Messages.app"
	"/Applications/Safari.app"
	"/System/Applications/Calendar.app"
	"/Applications/Microsoft OneNote.app"
)

for app in "${apps[@]}"; do
	dockutil --add "$app" --no-restart
done

dockutil --add '/Applications' --view grid --display folder --sort name --no-restart
dockutil --add '~/Downloads' --view grid --display stack --sort dateadded --no-restart
dockutil --add '~' --view grid --display folder --sort kind --no-restart

killall Dock
