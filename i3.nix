{ config, pkgs, ... }:

{
  # Graphical environment (DE/WM)
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.sddm = {
    enable = true;
    autoLogin.enable = false;
    autoLogin.user = "ludvig";
    autoNumlock = true;
  };

  services.xserver.windowManager.i3.enable = true;


  # environment.systemPackages = with pkgs; [
  #   kdeconnect
  #   kwalletmanager
  #   okular
  #   redshift-plasma-applet
  #   spectacle
  # ];
}
