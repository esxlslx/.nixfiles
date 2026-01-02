{pkgs, inputs, ... }: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];
  programs.spicetify = {
    enable = true;
    wayland = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      beautifulLyrics
      hidePodcasts
      shuffle
    ];
  };
}
