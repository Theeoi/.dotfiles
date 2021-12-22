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

The backlight.sh script allows for more control over the screen brightness.
Implement by running the script on a keybind. The first argument is either '+' och '-'.
```
./backlight.sh +/-
```
