# xautoscale

A small Bash helper that scales high-resolution displays with **xrandr**, so
everything on screen is easier to use without depending on desktop-environment
HiDPI settings.

## Why this exists

This project was created especially for **live forensic Linux distributions**
(for example [CAINE][caine], [DRIFT][drift], [Paladin][paladin]), where you
often boot into an unfamiliar environment on varied hardware and need
readable text and controls quickly.

Rather than relying on each desktop environment’s fractional scaling or HiDPI
options (which can be **inconsistent or buggy** in some live sessions)
**xautoscale** applies scaling at the **X11 / xrandr** level for the whole 
framebuffer. That tends to behave more predictably across different DEs and 
session types, and it also makes it easier to use **multiple screens with
different pixel densities** in one setup without wrestling with per-display
HiDPI in the desktop environment.

## What it does

For each connected output, the script reads the **current** resolution (the
mode marked with `*` in `xrandr` output). If the **smaller** of width and
height is greater than **1500** pixels, it runs:

```bash
xrandr --output <output> --scale 0.5x0.5 --filter nearest
```

Otherwise it leaves that output unchanged. Adjust the threshold or scale in
`xautoscale.sh` if your setup needs different values.

## Requirements

- X11 session with `xrandr` available
- Bash

## Usage

Make the script executable once:

```bash
chmod +x xautoscale.sh
```

Run it after your session is up (or from a startup hook / desktop autostart,
if your environment supports it):

```bash
./xautoscale.sh
```

## License

This project is released into the public domain under the Unlicense. See the
`LICENSE` file for the full legal text.

[caine]: https://www.caine-live.net/
[drift]: https://www.driftlinux.org/
[paladin]: https://sumuri.com/software/paladin/
