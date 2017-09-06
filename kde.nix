{ config, pkgs, ... }:

{
  # Graphical environment (DE/WM)
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      autoLogin.enable = true;
      autoLogin.user = "ludvig";
      autoNumlock = true;
    };

    desktopManager.plasma5.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdeconnect
    okular
    redshift-plasma-applet
    spectacle
  ];
}
