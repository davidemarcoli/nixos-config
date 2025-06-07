{ inputs, pkgs, config, ... }:

{
  home.stateVersion = "25.05";
  imports = [
    ./hyprland
    ./zsh
    ./git
  ];
}
