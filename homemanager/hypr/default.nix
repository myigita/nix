# default.nix
{ config, inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = { enable = true;
    systemd.enable = true;
    extraConfig = ''
# Custom

# See https://wiki.hyprland.org/Configuring/Monitors/
monitor=,preferred,auto,1

# windowrulev2 = float, class:.* # float as default
windowrulev2 = float, class:^(MEGAsync)$, title:^(MEGAsync)$
# windowrulev2 = float,title:^(kitty)$

#swaync
# layerrule = blur, swaync-control-center
# layerrule = blur, swaync-notification-window

# layerrule = ignorezero, swaync-control-center
# layerrule = ignorezero, swaync-notification-window

# layerrule = ignorealpha 0.5, swaync-control-center
# layerrule = ignorealpha 0.5, swaync-notification-window

# See https://wiki.hyprland.org/Configuring/Keywords/ for more

# Execute your favorite apps at launch
# exec-once = waybar & hyprpaper & firefox
exec-once = nm-applet
exec-once = swaync -s /shared/nix/homemanager/swaytools/swayncStyle.css -c /shared/nix/homemanager/swaytools/swayncConfig.json 
exec-once = waybar -c /shared/nix/homemanager/waybar/config -s /shared/nix/homemanager/waybar/style.css
exec-once = swww init & swww img /shared/nix/wallpapers/mp100black.png
exec-once = hypridle --config /shared/nix/homemanager/hypr/hypridle.conf
exec-once = lxqt-policykit-agent
exec-once = swayidle -w timeout 300 "$lockcommand" timeout 300 "hyprctl dispatch dpms off" resume "hyprctl dispatch dpms on && brightnessctl -r" before-sleep "$lockcommand before-sleep "$lockcommand""
exec-once = blueman 

$lockcommand = "swaylock -i /shared/nix/wallpapers/redrose.jpg && brightnessctl set 10%"



# Source a file (multi-file configs)
# source = ~/.config/hypr/myColors.conf

# Some default env vars.
env = XCURSOR_SIZE,24

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = yes
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 5
    gaps_out = 20
    border_size = 2
    col.active_border = rgba(dcd7baee)
    # col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)

    layout = dwindle

    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
    allow_tearing = false

    no_focus_fallback = 1
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 10
    
    blur {
        enabled = true
        size = 3
        passes = 1
    }

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)

	dim_inactive = true
	dim_strength = 0.5
}

animations {
    enabled = yes

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_is_master = true
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = true 
    workspace_swipe_numbered = true
    # workspace_swipe_forever = true
}

misc {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
# device:epic-mouse-v1 {
#     sensitivity = -0.5
# }

# Example windowrule v1
# windowrule = float, ^(kitty)$
# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, return, fullscreen, 0
bind = $mainMod, E, exec, kitty
bind = $mainMod, Q, killactive, 
bind = $mainMod, M, exit, 
bind = $mainMod, N, exec, nautilus 
bind = $mainMod, V, togglefloating, 
# bind = $mainMod, R, exec, wofi -ImGi --show drun
# bind = $mainMod, R, exec, rofi -show drun -show-icons
bind = $mainMod, R, exec, rofi -show drun -theme /shared/nix/homemanager/rofi/style-1.rasi
bind = $mainMod, P, pseudo, # dwindle
# bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod, F, fullscreen, 1
bind = $mainMod, escape, exec, sh /shared/nix/homemanager/rofi/powermenu.sh 
# bind = $mainMod, L, exec, swaylock -i /shared/nix/wallpapers/redrose.jpg
# bind = $mainMod, escape, exec, swaylock -i /shared/nix/wallpapers/redrose.jpg

# Move focus with mainMod + arrow keys
bind = $mainMod, h, movefocus, l
bind = $mainMod, l, movefocus, r
bind = $mainMod, k, movefocus, u
bind = $mainMod, j, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Example special workspace (scratchpad)
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Scroll through existing workspaces with mainMod + scroll
binde = $mainMod, Tab, workspace, e+1
# binde = $mainMod, Shift_L, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Brightness ctl
bind =, 232, exec, brightnessctl -q set 10%-
bind =, 233, exec, brightnessctl -q set +10%

# Volume ctl
bind =, xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ 
bind =, xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

bind =, Print, exec, hyprshot -m region -o /home/yigit/Pictures/Screenshots/

    '';
  };


}
