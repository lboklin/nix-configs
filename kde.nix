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

  services.xserver.desktopManager.plasma5 = {
    enable = true;
    # extraPackages = with pkgs; [
    #   yakuake
    #   dolphin
    #   khelpcenter
    # ];
  };

  # Workaround for https://github.com/NixOS/nixpkgs/issues/27050
  environment.variables.QT_PLUGIN_PATH = [ "${pkgs.plasma-desktop}/lib/qt-5.9/plugins/kcms" ];


  environment.systemPackages = with pkgs; [
    kdeconnect
    kwalletmanager
    okular
    redshift-plasma-applet
    spectacle
  ];
}
