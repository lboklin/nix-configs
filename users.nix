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

      aeki = {
        description = "Nessa";
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
        hashedPassword = "$6$4xdhLHLmNjcY$1V0yJ9EaDEIAWlVFTEPGHT79xxdTikaFDajpwmW0WHj4ComPIEA9eRBBqZ64AWtVlp44tpAYNNFyuKD.Y.ply/";
        home = "/home/aeki";
        isNormalUser = true;
      };
    };
  };
}
