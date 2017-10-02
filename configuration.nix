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

  # No hackerman bootup screen.
  boot.plymouth.enable = true;

  # Need this for graphics drivers, steam, etc.
  nixpkgs.config.allowUnfree = true;

  # Needed by Unity3D.
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
    gwenview
    kate
    keepassx2
    konsole
    openvpn
    powerline-fonts
    pulseaudioFull
    redshift
    smplayer
    source-code-pro
    #spotify # Unfree
    steam # Unfree
    tdesktop
    tmux
    tree

    # Dev
    ctags
    darcs
    git
    meld
    # Haskell dev
    cabal2nix
    ghc
    # ghci-ng

    # Editors/IDE's
    emacs
    neovim
    vim

    # Work-related
    mono46
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
  #system.stateVersion = "nixos-unstable";
  system.stateVersion = "17.09";
}
