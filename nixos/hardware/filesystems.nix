# Тут настраивается автомаунт нужных дисков
# Замени значения на свои. Узнать uuid можно через `lsblk -f`

{
  fileSystems = {
    "/mnt/Arch" =
    { device = "/dev/disk/by-uuid/4264f6c7-0b95-4ccb-bcc0-8895446288eb";
      fsType = "btrfs";
      options = [ "defaults" "noatime" "nosuid" "nodev" "nofail" "x-gvfs-show" ];
    };
     "/mnt/bine2" =
    { device = "/dev/disk/by-uuid/72fa6ecf-de34-4df9-990f-f4f85785ddf7";
      fsType = "ext4";
      options = [ "defaults" "noatime" "nosuid" "nodev" "nofail" "x-gvfs-show" ];
    };
    "/mnt/bine3" =
    { device = "/dev/disk/by-uuid/2f934d2b-ad39-46c8-a4ce-ea6a6b6e1912";
      fsType = "ext4";
      options = [ "defaults" "noatime" "nosuid" "nodev" "nofail" "x-gvfs-show" ];
    };
  };
}
