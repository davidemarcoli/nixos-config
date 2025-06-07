{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.git;

in {
  options.modules.git = { enable = mkEnableOption "git"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      git
    ];

    programs.git = {
      enable = true;
      userName = "davidemarcoli";
      userEmail = "davide@marcoli.ch";
      extraConfig = {
        gpg.format = "ssh";
        push.autoSetupRemote = true;
        user.signingKey = "~/.ssh/id_github";
        safe.directory = "/home/davidemarcoli/.config/nixos";
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
  };
}
