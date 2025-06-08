{ config, pkgs, inputs, ... }:

{
  environment.defaultPackages = [ ];
  services.xserver.desktopManager.xterm.enable = false;

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    git
  ];

  fonts = {
    fonts = with pkgs; [
      jetbrains-mono
      roboto
      openmoji-color
      #(nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) TODO
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = {
        emoji = [ "OpenMoji Color" ];
      };
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "davidemarcoli" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-delete-older-than 7d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  boot = {
    loader = {
      grub = {
       enable = true;
       device = "/dev/sda";
       useOSProber = true;
     };
   };
  };

  #boot = {
    #cleanTmpDir = true;
    #loader = {
    #  systemd-boot.enable = true;
    #  systemd-boot.editor = false;
    #  efi.canTouchEfiVariables = true;
    #  timeout = 0;
    #};
  #};

  time.timeZone = "Europe/Zurich";
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "sg";
  };

  users.users.davidemarcoli = {
    isNormalUser = true;
    extraGroups = [ "input" "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  networking = {
    networkmanager.enable = true;
    wireless.iwd.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 443 80 ];
      allowedUDPPorts = [ 443 80 44857 ]; # TODO: check that
      allowPing = false;
    };
  };

  environment.variables = {
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos";
  };

  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        users = [ "davidemarcoli" ];
        keepEnv = true;
        persist = true;
      }];
    };

    protectKernelImage = true;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
  };

  system.stateVersion = "25.05";
}
