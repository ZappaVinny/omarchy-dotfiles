# Waybar Server Status

A Waybar module that polls a list of servers and shows a green/yellow/red icon based on their status, with a hover tooltip showing each server and last poll time.

Copy serverstatus.sh to ~/.config/waybar/scripts/serverstatus.sh and chmod +x it.

Create ~/.config/waybar/serverstatus.conf with one server per line:

    Display Name | https://yourserver.com

Add "custom/serverstatus" to modules-right in config.jsonc:

    "custom/serverstatus": {
      "exec": "$HOME/.config/waybar/scripts/serverstatus.sh",
      "return-type": "json",
      "interval": 180
    }

Add #custom-serverstatus to your shared icon CSS rule and add the color classes to style.css:

    #custom-serverstatus.all-up    { color: #a3be8c; }
    #custom-serverstatus.some-down { color: #ebcb8b; }
    #custom-serverstatus.all-down  { color: #bf616a; }

Run omarchy-restart-waybar.
