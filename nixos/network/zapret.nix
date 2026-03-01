{inputs, ...}: {
  imports = [
    inputs.zapret-discord-youtube.nixosModules.default
  ];
  services.zapret-discord-youtube = {
    enable = true;
    configName = "general(ALT9)";
  };
}
