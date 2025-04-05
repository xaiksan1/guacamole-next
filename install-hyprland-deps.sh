#!/bin/bash

# Create installation script for Hyprland dependencies and additional utilities

echo "Installing Hyprland and core components..."
sudo pacman -S --needed \
    hyprland \
    waybar \
    dunst \
    wofi \
    grim \
    slurp \
    wl-clipboard \
    alacritty \
    polkit-gnome \
    network-manager-applet \
    pipewire \
    pipewire-pulse \
    wireplumber \
    xdg-desktop-portal-hyprland \
    qt5-wayland \
    qt6-wayland

# Create additional configuration directories
mkdir -p ~/.config/{dunst,wofi}

# Basic Dunst configuration
echo "# Dunst configuration
[global]
    monitor = 0
    follow = mouse
    width = 300
    height = 300
    origin = top-right
    offset = 10x50
    scale = 0
    notification_limit = 0
    progress_bar = true
    progress_bar_height = 10
    progress_bar_frame_width = 1
    progress_bar_min_width = 150
    progress_bar_max_width = 300
    indicate_hidden = yes
    transparency = 0
    separator_height = 2
    padding = 8
    horizontal_padding = 8
    text_icon_padding = 0
    frame_width = 3
    frame_color = "#8AADF4"
    separator_color = frame
    sort = yes
    font = JetBrains Mono 10
    line_height = 0
    markup = full
    format = "<b>%s</b>\n%b"
    alignment = left
    vertical_alignment = center
    show_age_threshold = 60
    ellipsize = middle
    ignore_newline = no
    stack_duplicates = true
    hide_duplicate_count = false
    show_indicators = yes
    icon_position = left
    min_icon_size = 0
    max_icon_size = 32
    sticky_history = yes
    history_length = 20
    browser = /usr/bin/xdg-open
    always_run_script = true
    title = Dunst
    class = Dunst
    corner_radius = 10
    ignore_dbusclose = false
    force_xwayland = false
    force_xinerama = false
    mouse_left_click = close_current
    mouse_middle_click = do_action, close_current
    mouse_right_click = close_all

[urgency_low]
    background = "#24273A"
    foreground = "#CAD3F5"
    timeout = 10

[urgency_normal]
    background = "#24273A"
    foreground = "#CAD3F5"
    timeout = 10

[urgency_critical]
    background = "#24273A"
    foreground = "#CAD3F5"
    frame_color = "#F5A97F"
    timeout = 0" > ~/.config/dunst/dunstrc

# Basic Wofi configuration
echo "window {
margin: 0px;
border: 1px solid #8AADF4;
background-color: #24273A;
border-radius: 15px;
}

#input {
margin: 5px;
border: none;
color: #CAD3F5;
background-color: #363A4F;
border-radius: 15px;
}

#inner-box {
margin: 5px;
border: none;
background-color: #24273A;
border-radius: 15px;
}

#outer-box {
margin: 5px;
border: none;
background-color: #24273A;
border-radius: 15px;
}

#scroll {
margin: 0px;
border: none;
}

#text {
margin: 5px;
border: none;
color: #CAD3F5;
} 

#entry:selected {
background-color: #363A4F;
border-radius: 15px;
}

#text:selected {
color: #8AADF4;
}" > ~/.config/wofi/style.css

echo "Installation and configuration complete!"
