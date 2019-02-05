#!/usr/bin/env bash

# Disable kwin and use i3-gaps as a window manager
export KDEWM=/usr/bin/i3

# Start the compton compositor
compton -b --config ~/.config/compton/compton.conf --blur-kern $(cat ~/.config/compton/gaussian-kernel-15x15)
