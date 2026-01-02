{ ... }: {
programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        source = "~/.config/fastfetch/miku.txt";
        padding = {
          top = 1;
          left = 1;
        };
      };

      display = {
        separator = " ";
        color = {
          keys = "magenta";
        };
        size = {
          ndigits = 0;
          maxPrefix = "GB";
        };
      };

      modules = [
        "break"

        {
          type = "title";
          color = {
            user = "green";
            at   = "red";
            host = "blue";
          };
        }

        {
          type = "os";
          key = "󰓎";
          format = "{pretty-name}";
        }

        {
          type = "os";
          key = "󰒕";
          format = "Hatsune Miku";
        }

        {
          type = "packages";
          key = "";
        }

        {
          type = "wm";
          key = "";
          format = "{pretty-name}";
        }
	{
	  type = "terminal";
	  key = "";
	  format = "{pretty-name}";
	}

        {
          type = "bluetooth";
          key = "";
          format = "{name} {battery-percentage}";
        }

	{
	 type = "disk";
	 key = "";
	 format = "{size-used}/{size-total} - {size-percentage}";
	}

        {
          type = "uptime";
          key = "";
          format = "{formatted}";
        }

        {
          type = "command";
          key = "󰃭";
          text = ''
            modify_install=$(stat -c %W /)
            current=$(date +%s)
            time_progression=$((current - modify_install))
            days_difference=$((time_progression / 86400))
            echo $days_difference days
          '';
        }

        {
          type = "colors";
          key = "󰌁";
          symbol = "circle";
        }
      ];
    };
  };
}
