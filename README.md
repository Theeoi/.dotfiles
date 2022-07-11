# My dotfiles and other useful scripts!

## Configs

A collection of my custom configfiles and some useful scripts.
Currently there are configs for:
- Git
- Bash
- Vim
- Nvim (with AstroNvim as base-config)

### Setup 

Implement the configs by cloning this repo and cd into it:

```
git clone https://github.com/Theeoi/.dotfiles.git
cd .dotfiles
```

Then create hard links from the home directory to your $HOME in the same
structure as in the repo.
This process is automated using the setup.sh script:

```
./setup.sh
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
