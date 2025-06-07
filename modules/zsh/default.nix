{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.zsh;
in {
  options.modules.zsh = { enable = mkEnableOption "zsh"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      zsh
    ];

    programs.pay-respects.enable = true;

    programs.zsh = {
      enable = true;
      
      # directory to put config files in
      dotDir = ".config/zsh";

      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;

      # .zshrc
      initExtra = ''
      '';

      # basically aliases for directories
      # `cd ~dots` will cd into ~/.config/nixos
      dirHashes = {
        dots = "$HOME/.config/nixos";
      };

      # Tweak settings for history
      history = {
        save = 10000;
        size = 10000;
        path = "$HOME/.cache/zsh_history";
      };

      shellAliases = {
        # ...
        rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG_DIR --fast; notify-send 'Rebuild Complete\!'";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };
  };
}
