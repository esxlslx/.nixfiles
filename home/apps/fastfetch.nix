{...}: {
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = "~/.config/fastfetch/pngs/Shinobu.png";
        height = 20;
        padding = {
          top = 2;
          right = 4;
          left = 4;
        };
      };

      display = {
        separator = " ▸ ";
        color = {
          keys = "green";
        };
      };

      modules = [
        "title"
        "separator"
        {
          type = "custom";
          format = "{#32}╭──────────── Software ────────────";
        }
        {
          type = "os";
          key = "│ OS";
        }
        {
          type = "kernel";
          key = "│ Kernel";
        }
        {
          type = "packages";
          key = "│ Packages";
          format = "{all}";
        }
        {
          type = "shell";
          key = "│ Shell";
        }
        {
          type = "wm";
          key = "│ WM";
        }
        {
          type = "terminal";
          key = "│ Terminal";
        }
        {
          type = "custom";
          format = "{#32}├──────────── Hardware ────────────";
        }
        {
          type = "cpu";
          key = "│ CPU";
        }
        {
          type = "gpu";
          key = "│ GPU";
        }
        {
          type = "memory";
          key = "│ Memory";
        }
        {
          type = "disk";
          key = "│ Disk";
        }
        {
          type = "custom";
          format = "{#32}├───────────── Uptime ─────────────";
        }
        {
          type = "uptime";
          key = "│ Uptime";
        }
        {
          type = "command";
          key = "│ OS Age";
          text = "days=$(( ($(date +%s) - $(stat -c %W /)) / 86400 )); echo $days days";
        }
        {
          type = "custom";
          format = "{#32}╰──────────────────────────────────";
        }
      ];
    };
  };
}
