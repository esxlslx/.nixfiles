{ pkgs, lib, config, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";       
        position = "top";
        spacing = 0;
        fixed-center = true;
        reload_style_on_change = true;
        
        modules-left = [
          "custom/separator"
          "niri/workspaces"
          "custom/separator"
          "niri/language"
          "custom/separator"
          "niri/window"
        ];
        
        modules-center = [ "clock" ];
        
        modules-right = [
	"group/tray-expander"
	"custom/separator"
	"cpu"
	"custom/separator"
	"memory"
	"custom/separator"
	"pulseaudio"
	"custom/separator"
	"custom/brightness"
	"custom/separator"
	"custom/notification"
	"custom/separator"
	"network"
	"custom/separator"
        ];

        # Modules configuration
        "niri/window" = {
          format = "{app_id}";
          icon = true;
          icon-size = 16;
          seperate-outputs = false;
          rewrite = {
            "io.github.kukuruzka165.materialgram" = "materialgram";
            "com.obsproject.Studio" = "obs";
            "com.github.th_ch.youtube_music" = "ytm";
            "com.mitchellh.ghostty" = "ghostty";
            "org.gnome.Nautilus" = "nautilus";
          };
        };

        "niri/language" = {
          format = "{}";
          format-en = "en";
          format-ru = "ru";
          format-uk = "ua";
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon} ";
          format-icons = {
            notification = "";
            none = "";
            dnd-notification = "";
            dnd-none = "";
            inhibited-notification = "";
            inhibited-none = "";
            dnd-inhibited-notification = "";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          escape = true;
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
        };

        "group/tray-expander" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "tray-group-item";
          };
          modules = [
            "custom/expand-icon"
            "tray"
          ];
        };

        "custom/expand-icon" = {
          format = "󰻋 ";
          tooltip = false;
        };

        tray = {
          icon-size = 16;
          spacing = 13;
        };

        clock = {
          format = "{:%H:%M %d/%m}";
          timezone = "Europe/Moscow";
	  calendar = {
	  format = {
	  days = "<span weight='normal'>{}</span>";
	  months = "<span color='#cdd6f4'><b>{}</b></span>";
	  today = "<span color='#f38ba8' weight='700'><u>{}</u></span>";
	  weekdays = "<span color='#f9e2af'><b>{}</b></span>";
	  weeks = "<span color='#a6e3a1'><b>W{}</b></span>";
	  };
	  mode = "month";
	  mode-mon-col = 1;
	  on-scroll = 1;
	  };
          tooltip-format = "<span color='#cdd6f4' font='Lexend 16'><tt><small>{calendar}</small></tt></span>";
          interval = 1;
          tooltip = true;
        };

        network = {
          format = "";
          format-wifi = "{icon}";
          format-ethernet = " ";
          tooltip-format = " ";
          format-linked = " ";
          format-disconnected = "󰤮 ";
          tooltip = false;
          on-click = "kitty sh -c nmtui";
          format-icons = ["󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 "];
        };
        pulseaudio = {
          scroll-step = 5;
          format = "<span font='Symbols Nerd Font'>{icon}</span> {volume}%";
          format-muted = "<span font='Symbols Nerd Font'> </span> Muted";
          format-source = "<span font='Symbols Nerd Font'></span> {volume}%";
          format-source-muted = "<span font='Symbols Nerd Font'></span>";
          format-icons = {
             default = ["" "" ""];
          };
          on-click = "pavucontrol";
          tooltip-format = "{volume}%";
          tooltip = false;
        };

        "custom/bluetooth" = {
          format = "";
          on-click = "blueberry";
          tooltip = false;
        };

          "custom/brightness" = {
            format = "   {text}%";
            signal = 8;
            exec = "~/.nixfiles/home/de-wm/brightness-control.sh get";
            on-scroll-up = "~/.nixfiles/home/de-wm/brightness-control.sh up";
            on-scroll-down = "~/.nixfiles/home/de-wm/brightness-control.sh down";
            on-click = "~/.nixfiles/home/de-wm/brightness-control.sh left_click";
            on-click-right =  "~/.nixfiles/home/de-wm/brightness-control.sh right_click";
            tooltip = false;
            };

        "custom/separator" = {
          format = "|";
          tooltip = false;
        };

        cpu = {
          interval = 5;
          format = "<span font='Symbols Nerd Font'> </span> {usage}%";
        };

        memory = {
          interval = 5;
          format = "<span font='Symbols Nerd Font'> </span> {percentage}%";
          tooltip-format = "Usage: {used:0.1f}G / {total:0.1f}G";
        };
      };
    };
  };

xdg.configFile."waybar/style.css".text = ''
*{
  font-size: inherit;
  font-family: inherit;
  font-weight: inherit;
}

button {
  border-radius: 0;
  box-shadow: none;
  background-color: transparent;
  border: 0;
}

window#waybar {
  background-color: transparent;
  transition-property: background-color;
  transition-duration: .5s;
  margin: 0;
  padding: 0;
}

window#waybar>box {
  margin: 0px;
  margin-bottom: 0px;
  border-radius: 0px;
  padding: 0px 0px;
  opacity: 1;
  background: @background;
  border: none;
}
/* Modules styling */
#custom-menu,
#custom-separator,
#workspaces,
#language,
#idle_inhibitor,
#custom-updates,
#window,
#group-tray-expander,
#custom-expand-icon,
#pulseaudio,
#backlight,
#network,
#battery,
#clock,
#custom-notification,
#custom-power {
  margin: 0px 1px;
  padding: 6px 5px;
  font-size: 14.5px;
  font-family: 'Caskaydia Cove Nerd Font', 'Adwaita Sans', 'Noto Sans', sans-serif;
  font-weight: 500;
  border-radius: 0px;
  border: none;
  background: transparent;
  opacity: 1;
  color: white;
}
#custom-brightness {
  margin: 0px 1px;
  padding: 6px 5px;
  font-size: 14.5px;
  font-family: 'Caskaydia Cove Nerd Font', 'Adwaita Sans', 'Noto Sans', sans-serif;
  font-weight: 500;
  border-radius: 0px;
  background: transparent;
  opacity: 1;
  color: white;
}

#custom-separator {
  opacity: .15;
  font-size: .9rem;
  margin: 0px;
  padding: 0px 4px;
}

/* Tray modules */
#custom-bluetooth,
#tray { margin: 0px 7px }

#custom-expand-icon {
  background: transparent;
  margin-right: 10px;
}

/* Fixes */
#custom-expand-icon {
  margin: 0;
  padding: 0;
  margin-right: 8px
}

#network {
  padding-right: 3px;
}

#group-tray-expander {
  margin: 0;
  padding: 0;
}

#language {
  margin-left: 4px
}

#custom-menu {
  padding-left: 12px;
  padding-right: 8px;
}

#idle_inhibitor {
  padding-left: 6px;
  padding-right: 4px
}

#custom-power {
  padding-right: 15px
}

#custom-notification {
  padding-right: 2px;
}

#window {
  opacity: .5
}

/* Styling */
#custom-menu,
#language,
#idle_inhibitor,
#custom-updates,
#pulseaudio,
#backlight,
#network,
#battery,
#clock,
#custom-notification,
#custom-power {
  transition: opacity .12s ease;
}

#custom-menu:hover,
#language:hover,
#idle_inhibitor:hover,
#custom-updates:hover,
#pulseaudio:hover,
#backlight:hover,
#network:hover,
#battery:hover,
#clock:hover,
#custom-notification:hover,
#custom-power:hover {
  opacity: .75
}

/* Battery states */
#battery.warning:not(.charging),
#battery.critical:not(.charging) { color: #ff8080 }
#battery.plugged:not(.charging)  { color: #ffe185 }
#battery.charging                { color: #88ff88 }

/* Hyprland/workspaces styling */
#workspaces {
  padding: 0;
  margin: 0;
}

#workspaces button {
  padding: 0px 5px;
  margin: 0px 0px;
  border: none;
  color: inherit;
  min-width: 0px;
  letter-spacing: 0px;
  box-shadow: none;
  background: transparent;
  opacity: .5;
  transition: color .08s ease, background .08s ease, opacity .08s ease;
}

#workspaces button.urgent              { color: #ff8080 }
#workspaces button.empty               { opacity: .25    }
#workspaces button.visible             { opacity: 1     }
#workspaces button:hover:not(.visible) { opacity: .8    }

tooltip {
  border-radius: 6px;
  background: black;
}
'';

  xdg.configFile."waybar/colors.css".text = ''
    /* generated from stylix */
    @define-color bg        #${config.lib.stylix.colors.base00};
    @define-color bg-alt    #${config.lib.stylix.colors.base01};
    @define-color fg        #${config.lib.stylix.colors.base05};
    @define-color fg-dim    #${config.lib.stylix.colors.base03};

    @define-color red       #${config.lib.stylix.colors.base08};
    @define-color orange    #${config.lib.stylix.colors.base09};
    @define-color yellow    #${config.lib.stylix.colors.base0A};
    @define-color green     #${config.lib.stylix.colors.base0B};
    @define-color cyan      #${config.lib.stylix.colors.base0C};
    @define-color blue      #${config.lib.stylix.colors.base0D};
    @define-color magenta   #${config.lib.stylix.colors.base0E};
  '';
}
