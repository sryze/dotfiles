# ~/.profile: executed by the command interpreter for login shells.

if [ -f "$HOME/.profile.local" ]; then
    . "$HOME/.profile.local"
fi

# Fix natural horizontal scrolling
# xinput set-prop 12 319 -75, -75

# Android
# export ANDROID_SDK_ROOT=$HOME/Tools/android/android-sdk
# export ANDROID_SDK_HOME=$HOME/Tools/android/android-sdk-home
# export PATH=$PATH:$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools

# Go
# export GOROOT=`realpath $HOME/Tools/go`
# export GOPATH=`realpath $HOME/Tools/go-packages`:`realpath $HOME/Projects/Go`
# export PATH=$PATH:`realpath $GOROOT/bin`:`realpath $HOME/Tools/go-packages/bin`:`realpath $HOME/Projects/Go/bin`

# Rust
# export CARGO_HOME=$HOME/Tools/cargo
# export PATH=$PATH:$CARGO_HOME/bin

# Make Qt shit look g00d
# export QT_QPA_PLATFORMTHEME=gtk2

# Ubuntu make installation of Ubuntu Make binary symlink
# export PATH=$HOME/.local/share/umake/bin:$PATH
