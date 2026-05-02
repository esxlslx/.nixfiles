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
          format = "{#90}╭──────────── {#32}Software {#90}────────────";
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
          format = "{#90}├──────────── {#32}Hardware {#90}────────────";
        }
        {
          type = "host";
          key = "│ Host";
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
          format = "{#90}├───────────── {#32}Uptime {#90}─────────────";
        }
        {
          type = "uptime";
          key = "│ Uptime";
        }
        {
          type = "custom";
          format = "{#90}╰──────────────────────────────────";
        }
      ];
    };
  };
}
