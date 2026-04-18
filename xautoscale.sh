#!/usr/bin/env bash

# Created by Andrea Lazzarotto.
# Released under CC0 1.0 (public domain).

THRESHOLD=1500
SCALE="0.5x0.5"

XRANDR_OUTPUT=$(xrandr)

echo "$XRANDR_OUTPUT" | grep " connected" | while read -r line; do
    output=$(awk '{print $1}' <<< "$line")

    res=$(echo "$XRANDR_OUTPUT" | awk -v out="$output" '
        $0 ~ "^"out" " {found=1}
        found && /\*/ {print $1; found=0}
    ')

    [ -z "$res" ] && continue

    width=${res%x*}
    height=${res#*x}

    min_dim=$(( width < height ? width : height ))

    echo "Checking $output: ${width}x${height} (min=$min_dim)"

    if (( min_dim > THRESHOLD )); then
        echo "> Scaling $output"
        xrandr --output "$output" --scale "$SCALE" --filter nearest
    else
        echo "> OK, skipping"
    fi
done
