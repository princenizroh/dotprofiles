#!/bin/bash
kitty --title="nvimunity" -- nvr --servername \
    "/tmp/nvimunity" --remote-tab-silent $@ && \
    if command -v wmctrl > /dev/null; then wmctrl -F -a nvimunity; fi
