#!/bin/bash
pkill eww
eww daemon -c /shared/nix/config/eww/
eww open bar -c /shared/nix/config/eww/
eww open bg_widgets -c /shared/nix/config/eww/
eww open notifications_popup -c /shared/nix/config/eww/
/shared/nix/config/eww/scripts/notifications.py &
