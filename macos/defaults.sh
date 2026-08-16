#!/usr/bin/env bash
#
# macOS defaults — captured from this machine on 2026-08-16.
# Only settings that differ from the stock macOS defaults are listed.
# Run: ./macos/defaults.sh  (then log out/in for everything to apply)

set -euo pipefail

###############################################################################
# General UI / UX                                                             #
###############################################################################

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Full keyboard access (Tab moves focus between all controls)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

# Disable press-and-hold accent popup (repeat keys instead)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Don't switch Spaces when activating an app
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool false

# Locale: US English with Sweden region
defaults write NSGlobalDomain AppleLocale -string "en_US@rg=sezzzz"
defaults write NSGlobalDomain AppleLanguages -array "en-US" "fa-SE" "sv-SE"

###############################################################################
# Trackpad & mouse                                                            #
###############################################################################

# Tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Tracking speed (trackpad fast, mouse medium)
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2

###############################################################################
# Dock & hot corners                                                          #
###############################################################################

# Auto-hide the Dock, no delay, faster animation
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5

# Dock on the right, small icons with magnification
defaults write com.apple.dock orientation -string "right"
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock largesize -int 128

# Don't show recent apps in the Dock
defaults write com.apple.dock show-recents -bool false

# Mission Control: don't group windows by app
defaults write com.apple.dock expose-group-apps -bool true

# Hot corners: bottom-right = Quick Note, top-left/top-right = disabled
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-tl-corner -int 1
defaults write com.apple.dock wvous-tr-corner -int 1

###############################################################################
# Finder                                                                      #
###############################################################################

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all drives/servers on the desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Default to list view (Nlsv), also for search results
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXPreferredSearchViewStyle -string "Nlsv"

# Don't write .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Keep Desktop/Documents out of iCloud Drive sync
defaults write com.apple.finder FXICloudDriveDesktop -bool false
defaults write com.apple.finder FXICloudDriveDocuments -bool false

###############################################################################
# Menu bar / Control Center                                                   #
###############################################################################

# Always show Sound in the menu bar (18 = always, 24 = when active, 8 = never)
defaults -currentHost write com.apple.controlcenter Sound -int 18

# Always show Bluetooth in the menu bar
defaults -currentHost write com.apple.controlcenter Bluetooth -int 18

# Show battery percentage
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true

# Hide Stage Manager icon from the menu bar
defaults -currentHost write com.apple.controlcenter StageManager -int 8

defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowDate -bool false
defaults write com.apple.menuextra.clock ShowAMPM -bool true

###############################################################################
# Screenshots                                                                 #
###############################################################################

# Default capture mode: selection; disable HDR screenshots
defaults write com.apple.screencapture style -string "selection"
defaults write com.apple.screencapture captureHDR -bool false

###############################################################################
# Apply                                                                       #
###############################################################################

killall Finder Dock SystemUIServer ControlCenter 2>/dev/null || true

echo "Done. Some changes require a logout/restart to take effect."
