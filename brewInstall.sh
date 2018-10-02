# A simple script coverts most of the brew packages I usually need
#

# Install brew if it doesn't exist
if ! type "brew" >/dev/null; then
  echo "Installing brew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew doctor
fi

echo "Update brew cache..."
brew update

# Found this from: https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
brew install coreutils
brew tap homebrew/dupes
brew tap homebrew/versions
brew install binutils
brew install diffutils
brew install ed --with-default-names
brew install findutils --with-default-names
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls --with-default-names
brew install grep --with-default-names
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget
brew install gdb  # gdb requires further actions to make it work. See `brew info gdb`.
brew install gpatch
brew install m4
brew install make

brew install file-formula
brew install git
brew install bash-completion
brew install less
brew install openssh --with-brewed-openssl
brew install vim --override-system-vi
brew install macvim --override-system-vim --custom-system-icons
brew install unzip
brew install tmux
brew install reattach-to-user-namespace


# brew cask install
brew tap caskroom/cask
brew cask install spectacle



cat >> ~/.bashrc << EOF
# Bash git completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

alias ls='gls --color=auto' ## Only works with 'brew install coreutils'

EOF
echo "*** Done! Restart a new terminal"
