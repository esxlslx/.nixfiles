{pkgs, ...}: {
  programs.fish.enable = true;

  users.users.falguren = {
    isNormalUser = true;
    description = "falguren";
    extraGroups = ["networkmanager" "wheel" "input" "libvirtd" "storage" "docker" "video" "i2c" "adbusers"];
    shell = pkgs.fish;
  };
}
