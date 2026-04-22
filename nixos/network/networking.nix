{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      checkReversePath = "loose";
      trustedInterfaces = ["throne-tun"];
      allowedTCPPorts = [4747];
      allowedUDPPorts = [4747];
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
    nameservers = ["9.9.9.9" "149.112.112.112" "8.8.8.8" "1.1.1.1" "8.8.8.4"];
  };
}
