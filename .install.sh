#!/bin/zsh

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

# Homebrew
## Install
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew analytics off

## Taps
echo "Tapping Brew..."
brew tap FelixKratz/formulae
brew tap koekeishiya/formulae

## Formulae
echo "Installing Brew Formulae..."
brew install wget
brew install jq
brew install ripgrep
brew install mas
brew install gh
brew install ifstat
brew install switchaudio-osx
brew install skhd
brew install borders
brew install yabai
brew install rclone

### Terminal
brew install neovim
brew install starship
brew install zsh-autosuggestions
brew install zsh-fast-syntax-highlighting
brew install zoxide

### Containers
brew install docker
brew install colima
brew install minikube
brew install k9s
brew install lazydocker

### Nice to have
brew install htop
brew install lazygit
brew install nnn

## Casks
echo "Installing Brew Casks..."
brew install --cask ghostty
brew install --cask google-chrome
brew install --cask zen-browser
brew install --cask zoom
brew install --cask slack
brew install --cask vlc
brew install --cask spotify

### Fonts
brew install --cask sf-symbols
brew install --cask font-sf-mono
brew install --cask font-sf-pro
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font

# macOS Settings
echo "Changing macOS defaults..."
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1 # enable browsing of all network interfaces
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true # prevent creation of .ds_store files on network drives
defaults write com.apple.spaces spans-displays -bool false # disable spaces spanning multiple displays
defaults write com.apple.dock autohide -bool true # enable dock auto-hide
defaults write com.apple.dock autohide-delay -float 0 # start showing dock immediatly
defaults write com.apple.dock autohide-time-modifier -float 0.5 # show whole dock in 0.5s
defaults write com.apple.dock "mru-spaces" -bool "false" # disable automatically rearranging spaces based on recent use
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false # disable window opening animations
defaults write com.apple.LaunchServices LSQuarantine -bool false # disable quarantine prompt for downloaded apps
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false # disable natural scrolling
defaults write NSGlobalDomain KeyRepeat -int 1 # set keyboard repeat rate to fast
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false # disable automatic spelling correction
defaults write NSGlobalDomain AppleShowAllExtensions -bool true # show all file extensions in finder
defaults write NSGlobalDomain _HIHideMenuBar -bool false # do not hide the menu bar by default
# defaults write NSGlobalDomain AppleHighlightColor -string "0.65098 0.85490 0.58431" # set highlight color to a custom green
defaults write NSGlobalDomain AppleAccentColor -int 1 # set accent color to orange
defaults write com.apple.screencapture location -string "$HOME/Desktop" # set screenshot save location to desktop
defaults write com.apple.screencapture disable-shadow -bool true # disable screenshot shadow
defaults write com.apple.screencapture type -string "png" # set screenshot format to png
defaults write com.apple.finder DisableAllAnimations -bool true # disable finder animations
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false # hide external hard drives from desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false # hide internal hard drives from desktop
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false # hide mounted servers from desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false # hide removable media from desktop
defaults write com.apple.Finder AppleShowAllFiles -bool true # show hidden files in finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # set finder search scope to current folder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false # disable warning when changing file extensions
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true # show full path in finder title
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv" # set finder view style to list view
defaults write com.apple.finder ShowStatusBar -bool false # hide status bar in finder
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES # prevent time machine from offering new disks for backup
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false # disable copying email addresses with names in mail app
# defaults write -g NSWindowShouldDragOnGesture YES # allow dragging windows with three-finger gesture
sudo defaults write com.apple.Safari AutoOpenSafeDownloads -bool false # disable safari auto-opening safe downloads
sudo defaults write com.apple.Safari IncludeDevelopMenu -bool true
sudo defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
sudo defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
sudo defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
killall Finder Dock SystemUIServer # apply most of the macOS defaults changes

## Fix for Bluetooth devices while using Wi-Fi
sudo defaults write /Library/Preferences/com.apple.airport.bt.plist bluetoothCoexMgmt Hybrid

## Copying and checking out configuration files
echo "Planting Configuration Files..."
[ ! -d "$HOME/dotfiles" ] && git clone --bare git@github.com:albsko/dotfiles.git $HOME/dotfiles
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout main

source $HOME/.zshrc
cfg config --local status.showUntrackedFiles no

## Start Services
echo "Starting Services (grant permissions)..."
brew services start skhd
brew services start fyabai
brew services start borders
