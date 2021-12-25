# My dotfiles and other useful scripts!

## Dotfiles

The three dotfiles are easily implemented by creating a symlink from the $HOME directory.

Example:
```
ln -s .dotfiles/.bashrc
```

The .vimrc will implement itself and install all plugins as you start vim.
The .bashrc is easily implemented through:
```
source .bashrc
```

## Scripts

### Backlight
The backlight.sh script allows for more control over the screen brightness.
Implement by running the script on a keybind. The first argument is either '+' och '-'.
```
./backlight.sh +/-
```

### Rotate-screen
The rotate-screen script allows for automatic rotation of the screen and touch inputs with an inbuilt accelerometer.
The script is well documented and is sourced from https://github.com/linux-surface/linux-surface/tree/master/contrib/rotate-screen
For automatic detection run:
```
./rotate-screen.sh screen
```
