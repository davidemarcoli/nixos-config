{ lib, pkgs, ... }
{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "davidemarcoli";
    homeDirectory = "/home/davidemarcoli";

    stateVersion = "25.05";
  };
};
