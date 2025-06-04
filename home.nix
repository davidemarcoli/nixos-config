{ config, lib, pkgs, ... }:
{
  imports = [ ./modules/default.nix ];
  modules = {
    hyprland.enable = true;
  };

  home = {
    packages = with pkgs; [
      hello
      firefox
      thefuck
      vscode
    ];

    username = "davidemarcoli";
    homeDirectory = "/home/davidemarcoli";

    stateVersion = "25.05";
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "vscode"
    ];

  programs.git = {
    enable = true;
    userName = "davidemarcoli";
    userEmail = "davide@marcoli.ch";
    extraConfig = {
      gpg.format = "ssh";
      push.autoSetupRemote = true;
      user.signingkey = "~/.ssh/id_github";
    };
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

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "~/.ssh/id_github";
      };
    };
  };

  #services.openssh = {
  #  enable = true;
  #  extraConfig = ''
  #    Host github.com
  #      HostName github.com
  #      PreferredAuthentication publickey
  #      IdentityFile ~/.ssh/id_github
  #  '';
  #};
}
