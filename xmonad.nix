{ config, pkgs, ... }:

{
  # Graphical environment (DE/WM)
  services = {
    # Enable the X11 windowing system.
    xserver = {
      displayManager.sddm = {
        enable = true;
        autoLogin.enable = true;
        autoLogin.user = "ludvig";
        autoNumlock = true;
      };

      windowManager = {
        default = "xmonad";
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
          extraPackages = haskellPackages: with pkgs.haskellPackages; [
            X11
            containers
            directory
            xmobar
            xmonad-utils
            xmonad-screenshot
            # xmonad-wallpaper # Missing dependency (xmonad 0.12.*)
            # xmonad-windownames # Missing dependency (xmonad 0.11.*)
          ];
        };
      };
    };

    compton = {
      enable = true;
      refreshRate = 144;
      shadow = false;
      fade = true;
      menuOpacity = "0.4";
      shadowExclude = [
        "window_type *= 'menu'"
      ];
    };
  };
  environment.systemPackages = with pkgs.haskellPackages; [
    xmobar
  ];
}
