# xmonad

Is a dynamically tiling X11 window manager that is written and configured in Haskell. In a normal WM, you spend half your time aligning and searching for windows. xmonad makes work easier, by automating this.

For more information of xmonad [here](https://xmonad.org/) and documentations [here](https://hackage.haskell.org/package/xmonad).

![xmonad - darknesscode](https://github.com/codedarkness/xmonad/blob/master/config-files/xmonad-arch-linux.png)

# What this do

* Install xmonad
  * Arch-based
  * Debian-based
* Install xmobar
  * Arch-based
  * Debian-based
* Install some extra programs (not required)
* Setup your preffer terminal
* Copy custom files

![xmonad - darknesscode](https://github.com/codedarkness/xmonad/blob/master/config-files/xmonad-debian.png)

## Software

Short list of some programs i use:

* Ranger file manager
* Nitrogen
* xfce4-power-manager
* xautolock (blurlock)
* urxvt (can be change)
* dnust

![xmonad - darknesscode](https://github.com/codedarkness/xmonad/blob/master/config-files/xmonad.png)

## Helpfull keybindings for this installation

| Keybinding  | Action                |
| :---------  | :------------------   |
| MOD+Enter   | Open terminal (urxvt) |
| MOD+r       | Ranger File Manager   |
| MOD+v       | Vim                   |
| MOD+Shift+o | dmenu_run             |
| MOD+0       | System account        |
| MOD+F12     | Lock screen           |
| MOD+Shift+r | Re-start xmonad       |
| MOD+Shift+q | Exit xmonad           |

Add your keybindings in /.xmonda/xmonad.hs. And change your terminal before installing

## Note

This is basic build of xmonad, you need to add your own stuff in xmonad.hs to create you own work flow. So, this is just a starting point to build your awesome system!

I use this built, and it's working. If you have an error(s) check in /.xmonad/xmonad.errors to know what is the problem.
