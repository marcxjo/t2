# t2 - A Manual Tiling Solution for Floating Window Managers

### About

`t2` was designed to afford some of the perqs of tiling window managers to floating window managers like Mutter, Xfwm,
and Marco. It can be used with a tiling window manager on floating-mode workspaces, but that's just silly.

These are the main design principles that guide development of `t2`:

* To be as friendly as possible to work with, _once you understand the proper invocation pattern_.
* To keep the command syntax both compact and easy to understand. The simplest invocation takes a single 4- or
  6-character argument, and the significance of each character is straightforward.
* To be easily adaptable for a more efficient workflow. Because tiling by script call is ultimately still not a
  particularly efficient way to place windows, being able to access the script via more efficient tools is ultimately
  what keeps it viable. The main use case I target is the ability to easily assign tiling configurations to keyboard
  shortcuts.

For simply placing a single window, this can still get rather clunky, depending on your needs. With a little
preconfiguration and a fuzzy-searching menu utility (e.g., dmenu or rofi), you can create a simple, fast, and flexible
workflow for window placement. t2 ships with scripts for both of the aforementioned utilities.

### Prerequisites

`t2` depends on `xdotool` for placement. To use the tiling menu scripts included, you will need to install either rofi
or dmenu.

For keyboard shortcuts, you can use `sxhkd` or the keyboard shortcut facilities provided by your desktop environment or
window manager.

The DE-specific config generators require that environment's configuration utility (xfconf for Xfce, dconf for MATE).

### Installing

`t2` is written to be easily installable at the user level. Simply copy the script to a directory in your $PATH
($HOME/bin is usually included in $PATH on most distros), and copy the config and cache directories to $HOME.

### Configuring

To get started with t2, run `t2 -r` to auto-generate a layout that respects your desktop environment's monitor
configuration  (e.g., panel placement). Xfce and MATE desktop environments are currently supported.

If you want gaps between your windows:

* Create $HOME/.config/t2/layouts/<monitor>, where <monitor> is the name of your monitor as provided by `xrandr`:

```
xrandr --listactivemonitors | tail -n+2 | awk '{gsub(/[+*]/, ""); print $2}'
```

At a minium, specify a`tile_gap`, e.g.,

```
tile_gap=32
```

Run `t2 -r` after editing to generate a new config with the desired gap setting.

Additional supported variables include `top_margin`, `bottom_margin`, `left_margin`, and `right_margin` for the
respective screen edges. If these variables are not configured, then they will be set to `tile_margin`. If the
`tile_margin` is not configured, then it (and the screen edge margins) will be set to 0.

### Syntax

`t2` is called with as a command line consisting of as few as two words.

The script takes one mandatory argument: a 4-character string that defines the placement of the window. The substrings
are explained in the code comments that accompany each variable. Below are some examples.

### Examples

Say you want to divide your desktop into five equally spaced horizontal tiles. If you have a window that needs a little
more space than a single tile, say 3 tiles, and you want it to take up the full vertical space across those tiles, focus
the window and call the following:

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

The optional second argument defines the padding `tile_gap` between windows. The default value is wide but maintains
decent readability on large screens.

Say you want to place a browser window on the right side of the screen, taking up just a little more than half your
screen space, and with room for a few smaller windows to the left. You also want a tighter margin for readability. The
following:

`t2 747f 32`

places your browser accordingly, and tightens the margin from the default 64 to 32px.

### Window Selection

Notice that the window has to be focused/selected in advance in order to place it. Some desktop enviroments' app
launchers accept `t2` invocations and place the focused window after closing. This has been tested with the launchers
shipped with GNOME and MATE.

`dmenu` and `rofi` are shown to behave similarly, and they tend to place windows much faster than GTK+-based launchers.

Note that `xfce4-appfinder` tends to (albeit consistently) place _itself_ before closing. If you're using Xfce and
insistent on using a GTK+ app, you might try building a tile cache like the one generated in the shipped menu scripts
and piping it to a zenity or yad dialogue for easy placement selection. Note, though, that I have not tested this use
case and cannot guarantee better results. (I _may_ work on this in the future, but I have no plans to for now.)

### Todo

Some features that will be coming to `t2` in the (hopefully near) future:

* Simple user install script - 'cause why not?

* Named presets - set e.g. `t2 topleft` or `t2 browser` for preferred/established window placements. (These would come
  at the cost of syntactic compactness but would lend advantages elsewhere.)

* Preconfigured divs - chop a character off of ${1}!

* Blacklisting via grep-ing window titles. This'll be tricky for windows whose names are subject to change, like
  browsers, terminals, and file managers.

### Thanks

Special thanks to grocid for gtile, on which this project is heavily based.

https://github.com/grocid/gtile
