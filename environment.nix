{ config, pkgs, ... }:

{
  # Choose one DE/WM.
  imports = [
    ./kde.nix
    # ./xmonad.nix
    ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      dejavu_fonts
      font-awesome-ttf
      hack-font
      noto-fonts
      source-code-pro
    ];
  };

  ## Shell stuff

  environment.systemPackages = [ pkgs.mercurial ]; # Needed by terminal prompt vcs plugin
  environment.shells = [ pkgs.zsh ];
  environment.etc."zshrc.local".text = ''
    export ZSH_CUSTOM="${./extra}"
    export ZSH_THEME="lambdagnoster"
    export DISABLE_AUTO_UPDATE="true"
    export COMPLETION_WAITING_DOTS="true"
    export DISABLE_UNTRACKED_FILES_DIRTY="true"
    export HIST_STAMPS="yyyy-mm-dd"
    export ZSH_TMUX_AUTOSTART=true
    export ZSH_TMUX_AUTOQUIT=false
    export ZSH_TMUX_AUTOCONNECT=false
  '';

  programs.zsh = {
    enable = true;
    promptInit = "";
    enableAutosuggestions = true;
    # syntaxHighlighting.enable = true; # Needs pattern specified?
    ohMyZsh = {
      enable = true;
      plugins = [
        "emacs"
        # "web-search"
        "cabal"
        "themes"
        # "zsh-syntax-highlighting"
        "git"
        "colorized-man-pages"
        "colorize"
        "tmux"
        "command-not-found"
        "safe-paste"
      ];
    };
  };

  environment.shellAliases = {
    g = "rg -i";
    l = "ls -lhAF --group-directories-first --color";

    # Git
    gcm = "git commit -m";
    gaacam = "git add -A && git commit -am";
  };
}
