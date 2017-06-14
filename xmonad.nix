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
        };
      };
    };

    # Maybe I'll need it?
    # compton = {
    #   enable = true;
    #   refreshRate = 144;
    #   shadow = true;
    #   fade = true;
    # };
  };
}
