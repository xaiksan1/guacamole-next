#!/bin/bash

# Installation script for Hyprland and dependencies on Debian-based systems
set -e

echo "=== Hyprland Installation Script for Debian-based Systems ==="
echo "This script will install Hyprland and its dependencies on Debian."
echo ""

# Check if running as root
if [ "$EUID" -eq 0 ]; then
  echo "Please do not run this script as root. It will use sudo when needed."
  exit 1
fi

# Install essential build tools and dependencies
echo "=== Installing build dependencies ==="
sudo apt update
sudo apt install -y \
    git \
    cmake \
    ninja-build \
    meson \
    build-essential \
    libwayland-dev \
    wayland-protocols \
    libwlroots-dev \
    libinput-dev \
    libxkbcommon-dev \
    libdisplay-info-dev \
    libseat-dev \
    seatd \
    libpango1.0-dev \
    libcairo2-dev \
    libgles2-mesa-dev \
    libegl1-mesa-dev \
    libdrm-dev \
    libgbm-dev \
    libsystemd-dev \
    xwayland \
    scdoc \
    dunst \
    wl-clipboard \
    libgtk-3-dev \
    polkit-kde-agent-1 \
    pipewire \
    pipewire-audio \
    xdg-desktop-portal \
    xdg-desktop-portal-gtk \
    network-manager-gnome \
    libdbus-1-dev

# Install available packages from repositories
echo "=== Installing available packages from repositories ==="
sudo apt install -y grim || echo "grim not available in repos, will build from source"
sudo apt install -y slurp || echo "slurp not available in repos, will build from source"
sudo apt install -y wofi || echo "wofi not available in repos, will build from source"
sudo apt install -y waybar || echo "waybar not available in repos, will build from source"
sudo apt install -y alacritty || echo "alacritty not available in repos, will build from source"

# Create build directory
mkdir -p ~/build
cd ~/build

# Function to build and install a package from GitHub
build_from_github() {
    local repo=$1
    local dir=$(basename "$repo")
    
    if [ ! -d "$dir" ]; then
        echo "=== Cloning $repo ==="
        git clone "https://github.com/$repo" "$dir"
    fi
    
    cd "$dir"
    git pull
    
    echo "=== Building $dir ==="
    if [ -f "meson.build" ]; then
        meson setup build --prefix=/usr/local -Dbuildtype=release
        ninja -C build
        sudo ninja -C build install
    elif [ -f "CMakeLists.txt" ]; then
        mkdir -p build
        cd build
        cmake -G Ninja -DCMAKE_BUILD_TYPE=Release ..
        ninja
        sudo ninja install
        cd ..
    fi
    
    cd ..
}

# Try to install grim from source if not available
if ! command -v grim &> /dev/null; then
    echo "=== Building grim from source ==="
    build_from_github "emersion/grim"
fi

# Try to install slurp from source if not available
if ! command -v slurp &> /dev/null; then
    echo "=== Building slurp from source ==="
    build_from_github "emersion/slurp"
fi

# Try to install wofi from source if not available
if ! command -v wofi &> /dev/null; then
    echo "=== Building wofi from source ==="
    build_from_github "uncomfyhalomacro/wofi"
fi

# Build Hyprland from source
echo "=== Building Hyprland from source ==="
if [ ! -d "Hyprland" ]; then
    git clone --recursive https://github.com/hyprwm/Hyprland
fi
cd Hyprland
git pull
git submodule update --init --recursive
meson setup build --prefix=/usr/local -Dbuildtype=release
ninja -C build
sudo ninja -C build install
cd ..

# Try to install waybar from source if not available
if ! command -v waybar &> /dev/null; then
    echo "=== Building waybar from source ==="
    build_from_github "Alexays/Waybar"
fi

# Try to install alacritty from source if not available
if ! command -v alacritty &> /dev/null; then
    echo "=== Building alacritty from source ==="
    
    # Install Rust if not available
    if ! command -v cargo &> /dev/null; then
        echo "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    fi
    
    build_from_github "alacritty/alacritty"
fi

cd ~

# Create configuration files and directories
echo "=== Creating configuration files ==="

# Create directories for configurations
mkdir -p ~/.config/{hypr,waybar,dunst,wofi}

# Create basic Hyprland configuration
echo "=== Creating Hyprland config ==="
cat > ~/.config/hypr/hyprland.conf << 'EOL'
# Hyprland Configuration

# Monitor configuration
monitor=,preferred,auto,1

# Execute at launch
exec-once = waybar & dunst & nm-applet

# Set cursor
env = XCURSOR_SIZE,24

# Input configuration
input {
    kb_layout = us
    follow_mouse = 1
    sensitivity = 0 # -1.0 - 1.0, 0 means no modification
    touchpad {
        natural_scroll = true
    }
}

# General window layout and behavior
general {
    gaps_in = 5
    gaps_out = 10
    border_size = 2
    col.active_border = rgba(8aadf4ee)
    col.inactive_border = rgba(595959aa)
    layout = dwindle
}

# Misc settings
misc {
    disable_hyprland_logo = true
    disable_splash_rendering = true
}

# Decoration settings (rounded corners, etc.)
decoration {
    rounding = 10
    blur {
        enabled = true
        size = 3
        passes = 1
    }
    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

# Animation settings
animations {
    enabled = true
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
}

# Layouts
dwindle {
    pseudotile = true
    preserve_split = true
}

master {
    new_is_master = true
}

# Window rules
windowrulev2 = float,class:^(pavucontrol)$
windowrulev2 = float,class:^(nm-connection-editor)$

# Key bindings
$mainMod = SUPER

bind = $mainMod, Return, exec, alacritty
bind = $mainMod, Q, killactive, 
bind = $mainMod SHIFT, Q, exit, 
bind = $mainMod, Space, togglefloating, 
bind = $mainMod, D, exec, wofi --show drun
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, S, togglesplit, # dwindle

# Move focus
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces
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

# Move window to workspace
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

# Screen capture
bind = $mainMod, Print, exec, grim -g "$(slurp)" - | wl-copy
EOL

# Create Waybar configuration
echo "=== Creating Waybar config ==="
cat > ~/.config/waybar/config.json << 'EOL'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "spacing": 4,
    "modules-left": ["hyprland/workspaces", "custom/media"],
    "modules-center": ["hyprland/window"],
    "modules-right": ["pulseaudio", "network", "cpu", "memory", "temperature", "backlight", "battery", "clock", "tray"],
    
    "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{name}: {icon}",
        "format-icons": {
            "1": "",
            "2": "",
            "3": "",
            "4": "",
            "5": "",
            "urgent": "",
            "focused": "",
            "default": ""
        }
    },
    
    "hyprland/window": {
        "format": "{}"
    },
    
    "tray": {
        "spacing": 10
    },
    
    "clock": {
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format": "{:%I:%M %p}",
        "format-alt": "{:%Y-%m-%d}"
    },
    
    "cpu": {
        "format": " {usage}%",
        "tooltip": false
    },
    
    "memory": {
        "format": " {}%"
    },
    
    "temperature": {
        "critical-threshold": 80,
        "format": "{icon} {temperatureC}°C",
        "format-icons": ["", "", ""]
    },
    
    "backlight": {
        "format": "{icon} {percent}%",
        "format-icons": ["", "", "", "", "", "", "", "", ""]
    },
    
    "battery": {
        "states": {
            "good": 95,
            "warning": 30,
            "critical": 15
        },
        "format": "{icon} {capacity}%",
        "format-charging": " {capacity}%",
        "format-plugged": " {capacity}%",
        "format-alt": "{icon} {time}",
        "format-icons": ["", "", "", "", ""]
    },
    
    "network": {
        "format-wifi": " {essid} ({signalStrength}%)",
        "format-ethernet": " {ipaddr}/{cidr}",
        "tooltip-format": " {ifname} via {gwaddr}",
        "format-linked": " {ifname} (No IP)",
        "format-disconnected": "⚠ Disconnected",
        "format-alt": "{ifname}: {ipaddr}/{cidr}"
    },
    
    "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-bluetooth": "{icon} {volume}% ",
        "format-bluetooth-muted": " {icon} ",
        "format-muted": " ",
        "format-source": " {volume}%",
        "format-source-muted": "",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
    },
    
    "custom/media": {
        "format": "{icon} {}",
        "return-type": "json",
        "max-length": 40,
        "format-icons": {
            "spotify": "",
            "default": ""
        },
        "escape": true,
        "exec": "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"
    }
}
EOL

# Create Waybar style file
echo "=== Creating Waybar style ==="
cat > ~/.config/waybar/style.css << 'EOL'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrains Mono", "Font Awesome 6 Free";
    font-size: 13px;
    min-height: 0;
}

window#waybar {
    background: rgba(36, 39, 58, 0.9);
    color: #cad3f5;
    transition-property: background-color;
    transition-duration: .5s;
    border-radius: 0px;
}

window#waybar.hidden {
    opacity: 0.2;
}

#workspaces button {
    padding: 0 5px;
    background-color: transparent;
    color: #cad3f5;
    border-radius: 0px;
}

#workspaces button:hover {
    background: rgba(54, 58, 79, 0.5);
    box-shadow: inherit;
}

#workspaces button.focused {
    background-color: #8aadf4;
    color: #24273a;
    border-radius: 0px;
}

#workspaces button.urgent {
    background-color: #f5a97f;
    color: #24273a;
}

#mode {
    background-color: #8aadf4;
    color: #24273a;
    padding: 0 5px;
    border-bottom: 3px solid #363a4f;
}

#clock,
#battery,
#cpu,
#memory,
#temperature,
#backlight,
#network,
#pulseaudio,
#custom-media,
#tray,
#mode,
#window {
    padding: 0 10px;
    margin: 0 4px;
    color: #cad3f5;
    border-radius: 10px;
}

#window {
    background-color: rgba(54, 58, 79, 0.4);
}

#workspaces {
    background-color: rgba(54, 58, 79, 0.4);
    padding: 0 5px;
    border-radius: 10px;
    margin: 4px;
}

#clock {
    background-color: rgba(138, 173, 244, 0.4);
    color: #cad3f5;
}

#battery {
    background-color: rgba(166, 218, 149, 0.4);
    color: #cad3f5;
}

#battery.charging, #battery.plugged {
    background-color: rgba(166, 218, 149, 0.8);
    color: #24273a;
}

@keyframes blink {
    to {
        background-color: #f5a97f;
        color: #24273a;
    }
}

#battery.critical:not(.charging) {
    background-color: #f5a97f;
    color: #24273a;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

label:focus {
    background-color: #24273a;
}

#cpu {
    background-color: rgba(236, 186, 187, 0.4);
    color: #cad3f5;
}

#memory {
    background-color: rgba(202, 158, 230, 0.4);
    color: #cad3f5;
}

#backlight {
    background-color: rgba(237, 230, 139, 0.4);
    color: #cad3f5;
}

#network {
    background-color: rgba(138, 173, 244, 0.4);
    color: #cad3f5;
}

#network.disconnected {
    background-color: #f5a97f;
    color: #24273a;
}

#pulseaudio {
    background-color: rgba(239, 159, 118, 0.4);
    color: #cad3f5;
}

#pulseaudio.muted {
    background-color: rgba(249, 226, 175, 0.4);
    color: #cad3f5;
}

#temperature {
    background-color: rgba(225, 184, 186, 0.4);
    color: #cad3f5;
}

#temperature.critical {
    background-color: #f5a97f;
    color: #24273a;
}

#tray {
    background-color: rgba(54, 58, 79, 0.4);
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: #f5a97f;
}

#custom-media {
    background-color: rgba(239, 159, 118, 0.4);
    color: #cad3f5;
    min-width: 100px;
}
EOL

# Create script for media player integration
mkdir -p ~/.config/waybar/
cat > ~/.config/waybar/mediaplayer.py << 'EOL'
#!/usr/bin/env python3
import argparse
import logging
import sys
import signal
import gi
import json
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib

logger = logging.getLogger(__name__)

def write_output(text, player):
    logger.info('Writing output')

    output = {'text': text,
              'class': 'custom-' + player.props.player_name,
              'alt': player.props.player_name}

    sys.stdout.write(json.dumps(output) + '\n')
    sys.stdout.flush()


def on_play(player, status, manager):
    logger.info('Received new playback status')
    on_metadata(player, player.props.metadata, manager)


def on_metadata(player, metadata, manager):
    logger.info('Received new metadata')
    track_info = ''

    if player.props.player_name == 'spotify' and \
            'mpris:trackid' in metadata.keys() and \
            ':ad:' in metadata['mpris:trackid']:
        track_info = 'AD PLAYING'
    elif player.get_artist() != '' and player.get_title() != '':
        track_info = '{artist} - {title}'.format(artist=player.get_artist(),
                                                 title=player.get_title())
    else:
        track_info = player.get_title()

    if player.props.status != 'Playing' and track_info:
        track_info = '⏸️ ' + track_info
    write_output(track_info, player)


def on_player_appeared(manager, player, selected_player=None):
    if player is not None and (selected_player is None or player.name == selected_player):
        init_player(manager, player)
    else:
        logger.debug("New player appeared, but it's not the selected player, skipping")


def on_player_vanished(manager, player):
    logger.info('Player has vanished')
    sys.stdout.write('\n')
    sys.stdout.flush()


def init_player(manager, name):
    logger.debug('Initialize player: {player}'.format(player=name.name))
    player = Playerctl.Player.new_from_name(name)
    player.connect('playback-status', on_play, manager)
    player.connect('metadata', on_metadata, manager)
    manager.manage_player(player)
    on_metadata(player, player.props.metadata, manager)


def signal_handler(sig, frame):
    logger.debug('Received signal to stop, exiting')
    sys.stdout.write('\n')
    sys.stdout.flush()
    sys.exit(0)
