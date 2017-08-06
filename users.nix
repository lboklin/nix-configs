{ config, pkgs, ... }:

{
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    # Default users.
    users = {
      ludvig = {
        description = "Ludvig";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        hashedPassword = "$6$qIbWA/cgpUhjV$ooWkoBifDLRnfWN6coqStIaN7XTl3Y059LoSkGOmU.sHYkB1y1RuQcc3DUFjRoA0TdWwln4BdH5lQO6wvKtlx.";
        home = "/home/ludvig";
        isNormalUser = true;
      };
    };
  };
}
