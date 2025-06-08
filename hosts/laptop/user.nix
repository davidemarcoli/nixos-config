{ config, lib, pkgs, ... }:
{
  imports = [ ../../modules/default.nix ];
  config.modules = {
    hyprland.enable = true;
    zsh.enable = true;
    git.enable = true;
    nvim.enable = true;
  };
}
