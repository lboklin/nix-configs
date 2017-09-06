{ config, pkgs, ... }:

{
  # Graphical environment (DE/WM)
  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
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
            X11-xft
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
      package = pkgs.compton-git;
      enable = true;
      refreshRate = 144;
      fade = true;
      inactiveOpacity = "0.95";
      menuOpacity = "0.8";
      shadow = true;
      shadowOffsets = [ (-8) (-8) ];
      # shadowExclude = [
      #   # "window_type *= 'menu'"
      #   # Maybe reduntant with -C option:
      #   "window_type *= 'dock'"
      #   "window_type *= 'panel'"
      # ];
      extraOptions = ''
        unredir-if-possible = true;
        no-dock-shadow = true;
        clear-shadow = true;
        shadow-radius = 10;
        detect-rounded-corners = true;
        shadow-ignore-shaped = true;

        # Window type settings
        wintypes:
        {
          notify = { fade = true; shadow = true; opacity = 0.9; focus = true; };
          tooltip = { fade = true; shadow = true; opacity = 0.9; focus = true; };
        };
      '';
    };
  };
  environment.systemPackages = with pkgs; [
    # compton
    rofi
    haskellPackages.xmobar
  ];
}
