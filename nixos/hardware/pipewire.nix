{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    jack.enable = true;
    pulse.enable = true;

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 128;
        "default.clock.min-quantum" = 128;
        "default.clock.max-quantum" = 128;
      };
    };
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
}
