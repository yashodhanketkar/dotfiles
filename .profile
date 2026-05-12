# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

FZF_BASE=/usr/bin/fzf

GOPATH="$HOME/go"
ANDROID_SDK_ROOT="$HOME/Android/Sdk/"

ANDROID_HOME="$HOME/Android"
ANDROID_NDK_HOME="$HOME/Android/Sdk/ndk/28.2.13676358/"
# JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
CHROME_EXECUTABLE="/usr/bin/chromium"
SONAR_SCANNER_HOME="/opt/sonar-scanner"

PATH="$HOME/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
PATH="/home/lou/.dotnet/tools:$PATH"
PATH="/home/lou/.config/composer/vendor/bin/:$PATH"
PATH="/home/lou/develop/flutter/bin/:$PATH"
PATH="$HOME/.cargo/bin:$PATH"
PATH="$GOPATH/bin:$PATH"
PATH="$JAVA_HOME/bin:$PATH"
PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"
PATH="$ANDROID_SDK_ROOT/emulator:$PATH"
PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH"
PATH="${SONAR_SCANNER_HOME}/bin:$PATH"

XCURSOR_THEME="Bibata-Modern-Ice"
XCURSOR_SIZE=24
