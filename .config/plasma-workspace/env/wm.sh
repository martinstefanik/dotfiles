#!/usr/bin/env bash

# Disable kwin and use i3-gaps as a window manager
export KDEWM=/usr/bin/i3

# Start the compton compositor
compton & --config ~/.config/compton/compton.conf
