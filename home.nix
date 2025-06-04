{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
      firefox
      thefuck
    ];

    username = "davidemarcoli";
    homeDirectory = "/home/davidemarcoli";

    stateVersion = "25.05";
  };

  programs.git = {
    enable = true;
    userName = "davidemarcoli";
    userEmail = "davide@marcoli.ch";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -al";
      update = "sudo nixos-rebuild switch";
      update-home = "make -C ~/nixos-config";
    };
    history.size = 10000;
   
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "robbyrussell";
    };
  };
}
