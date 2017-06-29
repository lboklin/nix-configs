{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./peripherals.nix
  ];

  ## Storage devices ##

  boot.loader.grub = {
    enable = true;
    version = 2;
    # Define on which hard drive you want to install Grub.
    device = "/dev/sdb"; # or "nodev" for efi only
    useOSProber = true;
  };

  fileSystems = {
    "/data" = {
      device = "/dev/disk/by-label/data";
      fsType = "ext4";
    };

    "/data/neon-home" = {
      device = "/dev/disk/by-label/Home";
      fsType = "ext4";
    };
  };

  ## Graphics card ##

  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.extraDisplaySettings = ''
    Option         "metamodes" "DVI-D-0: 1920x1080_144 +0+0 {ForceCompositionPipeline=On}"
  '';
}
