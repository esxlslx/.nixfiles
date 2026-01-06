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
      allowedTCPPorts = [ 4747 ];
      allowedUDPPorts = [ 4747 ];
    };
  };
  
  services.blueman.enable = true;
}
