# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sdb"; # or "nodev" for efi only
    useOSProber = true;
    # extraEntries = ''
    #   menuentry "KDE Neon" {
    #     insmod gzio
    #     insmod part_msdos
    #     insmod ext2
    #     chainloader (hd0,msdos5)+1
    #   }
    # '';
  };

  fileSystems = {
    "/data" = {
      device = "/dev/disk/by-label/data";
      fsType = "ext4";
    };

    # "/nix/store" = {
    #   device = "/data/nix/store";
    #   fsType = "ext4";
    #   options =
    #     [ "defaults"
    #       "bind"
    #     ];
    # };

    "/data/neon-home" = {
      device = "/dev/disk/by-label/Home";
      fsType = "ext4";
    };
  };


  # Hostname.
  networking.hostName = "nixos";
  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true;

  # Select internationalisation properties.
  i18n = {
    #consoleFont = "";
    #consoleKeyMap = "dvorak-sv-a5";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Networking, yes please.
  networking.networkmanager.enable = true;

  hardware = {
    # I want audio control.
    pulseaudio.enable = true;
    # and with 32-bit support
    pulseaudio.support32Bit = true;
    # Enable hardware acceleration for 32-bit applications on a 64-bit system.
    opengl.driSupport32Bit = true;
    bluetooth.enable = true;
  };

  # Steam Controller
  # This allows SC-Controller application and daemon to access Steam Controller or its USB dongle.
  # This is done by allowing read/write access to all users. You may want to change this to something like
  # MODE="0660", GROUP="games" to allow r/w access only to members of that group.
  services.udev.extraRules = ''
    # This rule is needed for basic functionality of the controller in Steam and keyboard/mouse emulation
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
    # This rule is necessary for gamepad emulation
    KERNEL=="uinput", MODE="0660", GROUP="users", OPTIONS+="static_node=uinput"
    # Valve HID devices over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0666"
    # Valve HID devices over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0666"
  '';

  # Untested:
  # services.udev.extraRules = ''
  #   # Valve USB devices
  #   SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
  #   # uinput kernel module write access (allows keyboard, mouse and gamepad emulation)
  #   KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess"
  # '';

  # With this, the steam controller didn't work
  # services.udev.extraRules = ''
  #   SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0666"
  #   KERNEL=="uinput", MODE="0660", GROUP="users", OPTIONS+="static_node=uinput"
  # '';

  # Keep system up-to-date automatically.
  system.autoUpgrade.enable = true;

  # Extra system packages.
  environment.systemPackages = with pkgs; [
    bluez
    cryptsetup
    deluge
    emacs
    electron
    filelight
    firefox
    git
    gparted
    kdeconnect
    keepassx2
    mercurial
    mono
    mono-addins
    monodevelop
    neovim
    nethogs
    nodejs
    npm2nix
    okular
    openvpn
    powerline-fonts
    source-code-pro
    spectacle
    stow
    redshift
    redshift-plasma-applet
    ripgrep
    smplayer
    steam
    tmux
    vim
    vlc
    wget
  ];

  # Default users.
  users.extraUsers.ludvig = {
    isNormalUser = true;
    home = "/home/ludvig";
    description = "Ludvig";
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$qIbWA/cgpUhjV$ooWkoBifDLRnfWN6coqStIaN7XTl3Y059LoSkGOmU.sHYkB1y1RuQcc3DUFjRoA0TdWwln4BdH5lQO6wvKtlx.";
  };

  users.extraUsers.aeki = {
    isNormalUser = true;
    home = "/home/aeki";
    description = "Nessa";
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$4xdhLHLmNjcY$1V0yJ9EaDEIAWlVFTEPGHT79xxdTikaFDajpwmW0WHj4ComPIEA9eRBBqZ64AWtVlp44tpAYNNFyuKD.Y.ply/";
  };

  # Shell.
  programs.zsh.enable = true;
  programs.zsh.promptInit = "";
  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  # I'm sorry Mr. Stallman
  nixpkgs.config.allowUnfree = true;
  # Unity3D requirement
  security.chromiumSuidSandbox.enable = true;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      hack-font
      source-code-pro
      noto-fonts
    ];
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "se";
    xkbVariant = "dvorak_a5";
    xkbOptions = "terminate:ctrl_alt_bksp, caps:escape";
    videoDrivers = [ "nvidia" ];

    displayManager = {
      sddm.enable = true;
      sddm.autoLogin.enable = true;
      sddm.autoLogin.user = "ludvig";
      sddm.autoNumlock = true;
    };

    # Enable the KDE Desktop Environment.
    desktopManager = {
      plasma5.enable = true;
      plasma5.extraPackages = with pkgs; [
        yakuake
        dolphin
        khelpcenter
      ];
    };

    # Input.
    libinput = {
      enable = true;
      accelProfile = "flat";
    };

    # Xorg.conf
    # config =
    #   ''
    #   # nvidia-settings: X configuration file generated by nvidia-settings
    #   # nvidia-settings:  version 375.39  (nixbld3@)  Tue May  2 20:47:29 UTC 201
    #   Section "ServerLayout"
    #       Identifier     "Layout0"
    #       Screen      0  "Screen0" 0 0
    #       InputDevice    "Keyboard0" "CoreKeyboard"
    #       InputDevice    "Mouse0" "CorePointer"
    #       Option         "Xinerama" "0"
    #   EndSectio
    #   Section "Files"
    #   EndSectio
    #   Section "InputDevice"
    #       # generated from default
    #       Identifier     "Mouse0"
    #       Driver         "mouse"
    #       Option         "Protocol" "auto"
    #       Option         "Device" "/dev/input/mice"
    #       Option         "Emulate3Buttons" "no"
    #       Option         "ZAxisMapping" "4 5"
    #   EndSectio
    #   Section "InputDevice"
    #       # generated from default
    #       Identifier     "Keyboard0"
    #       Driver         "kbd"
    #   EndSectio
    #   Section "Monitor"
    #       # HorizSync source: edid, VertRefresh source: edid
    #       Identifier     "Monitor0"
    #       VendorName     "Unknown"
    #       ModelName      "PKB Maestro 242DX"
    #       HorizSync       31.0 - 83.0
    #       VertRefresh     56.0 - 76.0
    #       Option         "DPMS"
    #   EndSectio
    #   Section "Device"
    #       Identifier     "Device0"
    #       Driver         "nvidia"
    #       VendorName     "NVIDIA Corporation"
    #       BoardName      "GeForce GTX 680"
    #   EndSectio
    #   Section "Screen"
    #       Identifier     "Screen0"
    #       Device         "Device0"
    #       Monitor        "Monitor0"
    #       DefaultDepth    24
    #       Option         "Stereo" "0"
    #       Option         "nvidiaXineramaInfoOrder" "DFP-3"
    #       Option         "metamodes" "DVI-I-1: nvidia-auto-select +1920+0, DVI-D-0: 1920x1080_144 +0+0 {ForceCompositionPipeline=On}"
    #       Option         "SLI" "Off"
    #       Option         "MultiGPU" "Off"
    #       Option         "BaseMosaic" "off"
    #       SubSection     "Display"
    #           Depth       24
    #       EndSubSection
    #   EndSection
    #   '';
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  #system.stateVersion = "17.03";
  system.stateVersion = "nixpkgs-unstable";
}
