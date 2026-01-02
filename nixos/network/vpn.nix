{ config, pkgs, inputs, ... }:
{
  #Throne
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
}
