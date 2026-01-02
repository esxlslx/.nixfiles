# Тут будет настройка гибернации в файл подкачки
# Файл подкачки создан в /etc/nixos/hardware-configuration.nix

# Проверить установлен ли сейчас resume: cat /sys/power/resume
# Если 0:0, то ничего не указано

# Узнать uuid файла подкачки:
# lsblk `df /swapfile | awk '/^\/dev/ {print $1}'` -no UUID

# Узнать offset файла подкачки:
# sudo filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'

{
  boot = {
    resumeDevice = "/dev/disk/by-uuid/0951089a-fd89-4647-9ddb-0e3ff63d7b49";
    kernelParams = [ "resume_offset=6799360" ];
  };

  # Не знаю надо ли это. На виртуалке я не могу забутиться в любом случае
  # boot.initrd.systemd.enable = true;
}
