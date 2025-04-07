# copyStuff

This is my attemp to make a shortcut I regularly use more...flexible, so that it can be useful for more...copying.

Currently I copy a single string with `xclip`.

This is an attempt to make it functional in both Xorg, as it is now, as well as Wayland (without XWayland). At the same time I figured I can just as well split up the strings it is to copy from the functionality of actually performinng the copy operation, either with `xclip` or `wl-clipboard` depending on whether you are using Xorg or Wayland.

So this "program"/script/functionality is split into two files:
* a Config file named `copyStuff.conf` located at `$HOME/.config/`. This file contains everything that can be copied in a neat file.
* The script, called `copyStuff.sh` which is a simpple bash script that performs the copy. This file shouold be copied to `$HOME/.local/bin/`. That way they don't get overridden because of _something_, and it makes the internal function `cps` available in terminal sessions.

## Installation

I'm not going to package something _this_ simple an installable archive or something of the sort. I'm not even going to upload it to the [AUR](https://aur.archlinux.org/). This is way to simple for something like that. Instead just:

1. Download and copy the empty `copyStuff.conf` file to `$HOME/.config/` so that the eventual path is `$HOME/.config/copyStuff.conf`. This way every user has his/her/its own list of things to copy.
2.1. For a local (user-only) installation, download and move the `copyStuff.sh` script into your local user's `$HOME/.local/bin/`. I'm using Manjaro, but I suspect it'll be the same, or at least similar, on many other a distro.
2.2. For a global (system-wide) installation, download and copy the `copyStuff.sh` somewhere that system-wide scripts are kept. On my system I use `/usr/local/bin` for this, so the complete path for me  would be `/usr/local/bin/copyStuff.sh`. Yours might differ.
   #### Note:
   The global installation is _only_ for the script. The _stuff_ (to use a technical word) to copy must still be defined per-user, as desribed below.
4. Add the full path `copyStuff.conf` to your `~/.bashrc` or `~/.zshrc` or whatever you use. Asssuming the script has been saved as `$HOME/.config/copyStuff.conf` the line to add it would be:

```
source $HOME/.local/bin/copyStuff.conf
```

_Adjust the path accordingly if you did a global installation._
I use ZSH, but the script is written in bash, and the shebang is for bash, so it should work for you as well. Adjust to your needs if neccesary.

Now simply source/reload your `~/.bashrc` or `~/.zshrc` file and:

```
source <~/.bashrc or ~/.zshrc>
```

...and you _should_ be good to go. It should also work after a reboot, if that will be eaier. Or a simple relogin. And it should persist after a reboot/relogin.

## Dependencies

Well, I don't belive in re-inventing the wheel, so I use some things that have beenn built before so why would I re-invent those or roll my own? So without further ado:

* `xclip` if you use X11; or
* `wl-clipboard` if you use Wayland; and
* `libnotify` for displaying the notification that the copy process was sucessfull.

To test if it's loaded, in a terminal emulator, simply do:

```
cps -h
```


## Usage:

...is easy. That's why I made this, after all. After Simply run `cps <stringToCopy>`. For example:

```
cps ok
```

This will copy whatever is defined as `bye` in the `$HOME/.config/copyStuff.conf` config file.

