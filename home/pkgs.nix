{pkgs, ...}: {
  home.packages = with pkgs; [
    ## Some apps
    materialgram

    ## CLI pkgs
    gh
    dust
    conceal
    nix-melt
    microfetch
    speedtest-go
    bitwarden-cli
    nur.repos.zerozawa.mikusays

    ## Dev
    go
    python313
    android-tools
  ];
}
