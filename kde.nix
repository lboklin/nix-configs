{ config, pkgs, ... }:

{
  # Graphical environment (DE/WM)
  # Enable the X11 windowing system.
  services.xserver = {
    displayManager.sddm = {
      enable = true;
      autoLogin.enable = false;
      autoLogin.user = "ludvig";
      autoNumlock = true;
    };

    desktopManager.plasma5 = {
      enable = true;
      extraPackages = with pkgs; [
        yakuake
        dolphin
        khelpcenter
      ];
    };
  };
}
