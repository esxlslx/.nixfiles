{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };

    /*loader = {
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev"; # nodev позволяет не устанавливать grub в конкретное место, но видеть его ui
      };
      efi.canTouchEfiVariables = true;
    };*/

    tmp.cleanOnBoot = true;

    extraModprobeConfig = "options amdgpu ppfeaturemask=0xffffffff" ;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
