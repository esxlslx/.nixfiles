{
    hardware.bluetooth = {
    enable = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      checkReversePath = "loose";
      trustedInterfaces = [ "throne-tun" ];
    };
  };
  
  services.blueman.enable = true;
}
