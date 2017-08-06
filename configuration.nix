# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./environment.nix
    ./users.nix
  ];

  boot.plymouth.enable = true;

  # Need this for graphics drivers, steam, etc.
  nixpkgs.config.allowUnfree = true;

  # Needed by Unity3D
  security.chromiumSuidSandbox.enable = true;

  # Select internationalisation properties.
  i18n = {
    #consoleFont = "";
    # This made me unable to input special characters:
    #consoleKeyMap = "dvorak-sv-a5";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  services.openssh.enable = true;
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  hardware = {
    pulseaudio = {
      enable = true;
      # systemWide = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
    # Enable hardware acceleration for 32-bit applications on a 64-bit system.
    opengl.driSupport32Bit = true;
  };

  services.syncthing = {
    enable = true;
    dataDir = /etc/nixos/extra/syncthing;
    openDefaultPorts = true;
    useInotify = true;
  };

  # Snowdrift dev
  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql94;

  # Extra system packages.
  environment.systemPackages = with pkgs; [
    # Misc/General
    ark
    cryptsetup
    deluge
    electron
    filelight
    firefox
    gparted
    keepassx2
    konsole
    openvpn
    powerline-fonts
    pulseaudioFull
    redshift
    smplayer
    source-code-pro
    steam # Unfree
    tmux

    # Dev
    darcs
    git
    nodejs
    npm2nix

    # Editors/IDE's
    emacs
    neovim
    vim

    # Work-related
    mono
    mono-addins
    monodevelop
    unity3d # Unfree

    # Misc/Utils (config/admin)
    nethogs
    ripgrep
    stow
    wget
  ];

  # Keep system up-to-date automatically.
  system.autoUpgrade.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  #system.stateVersion = "17.03";
  system.stateVersion = "nixpkgs-unstable";
}
