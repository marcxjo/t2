# t2 - PLACEMENT DAY

Known elsewhere by its more verbose title "t2 - A Highly Customizable Tiling Script Designed for Use with Keyboard Shortcuts."

### Getting Started

`t2` was designed to afford some of the perqs of tiling window managers to floating window managers like Mutter, Xfwm, and Marco. It can be used with a tiling window manager on floating-mode workspaces, but that's just silly.

These are the main design principles that guide development of `t2`:

* To be as friendly as possible to work with, _once you understand the proper invocation pattern_.
* To keep the command syntax both compact and easy to understand. In its current state, the script takes a single 4-character argument, and the significance of each character is straightforward.
* To be easily adaptable for a more efficient workflow. Because tiling by script call is ultimately still not a particularly efficient way to place windows, being able to access the script via more efficient tools is ultimately what keeps it viable. The main use case I target is the ability to easily assign tiling configurations to keyboard shortcuts.

For simply placing a single window, this can still get rather clunky, depending on your needs. With a little preconfiguration and the help of simple menu scripts (like the rofi and dmenu tilers included with the script), you can simplify the task a bit by simply typing in a portion of the desired tiling command and scrolling through a short list of tiling possibilities.

### Prerequisites

`t2` depends on `xdotool` for placement. To use the tiling menu scripts included, you will need to install either rofi or dmenu.

For keyboard shortcuts, you can use `sxhkd` or the keyboard shortcut facilities provided by your desktop environment or window manager.

### Installing

`t2` is written to be easily installable at the user level. Simply copy the script to a directory in your $PATH ($HOME/bin is usually included in $PATH on most distros), and copy the config and cache directories to $HOME.

### Syntax

`t2` is called with as a command line consisting of as few as two words.

The script takes one mandatory argument: a 4-character string that defines the placement of the window. The substrings are explained in the code comments that accompany each variable. Below are some examples.

### Examples

Say you want to divide your desktop into five equally spaced horizontal tiles. If you have a window that needs a little more space than a single tile, say 3 tiles, and you want it to take up the full vertical space across those tiles, focus the window and call the following:

`t2 513f`

Keeping the dimensions the same, you can center the window (i.e., using all but the first and tiles) like this:

`t2 524f`

or place it to the far right like this:

`t2 535f`

If you want your applications window to occupy only the upper (/_higher_) half of spaces 1 through 3:

`t2 513h`

And if you want it to occupy only the _lower_ half of spaces 1 through 3:

`t2 513l`

So far the only vertical possibilities are [f]ull-tile, [h]igh-tile, and [l]ow-tile placement.

The optional second argument defines the padding tile_gap between windows. The default value is wide but maintains decent readability on large screens.

Say you want to place a browser window on the right side of the screen, taking up just a little more than half your screen space, and with room for a few smaller windows to the left. You also want a tighter margin for readability. The following:

`t2 747f 32`

places your browser accordingly, and tightens the margin from the default 64 to 32px.

### Window Selection

Notice that the window has to be focused/selected in advance in order to place it. Some desktop enviroments' app launchers accept `t2` invocations and place the focused window after closing. This has been tested with the launchers shipped with GNOME and MATE.

`dmenu` and `rofi` are shown to behave similarly, and they tend to place windows much faster than GTK+-based launchers.

Note that `xfce4-appfinder` tends to (albeit consistently) place _itself_ before closing. If you're using Xfce and insistent on using a GTK+ app, you might try building a tile cache like the one generated in the shipped menu scripts and piping it to a zenity or yad dialogue for easy placement selection. Note, though, that I have not tested this use case and cannot guarantee better results. (I _may_ work on this in the future, but I have no plans to for now.)

### Todo

Some features that will be coming to `t2` in the (hopefully near) future:

* Simple user install script - 'cause why not?

* Named presets - set e.g. `t2 topleft` or `t2 browser` for preferred/established window placements. (These would come at the cost of syntactic compactness but would lend advantages elsewhere.)

* Preconfigured divs - chop a character off of ${1}!

* Blacklisting via grep-ing window titles. This'll be tricky for windows whose names are subject to change, like browsers, terminals, and file managers.

### Thanks

Special thanks to grocid for gtile, on which this project is heavily based.

https://github.com/grocid/gtile
