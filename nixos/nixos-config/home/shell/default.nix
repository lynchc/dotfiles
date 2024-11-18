{
  imports = [ ./starship.nix ./terminals.nix ./thefuck.nix ];

  home.sessionVariables = {
    BROWSER = "google-chrome-stable";
    DEFAULT_BROWSER = "google-chrome-stable";
    TERMINAL = "kitty";
    TERM = "kitty";
    VISUAL = "vim";
    EDITOR = "vim";
    DIRENV_LOG_FORMAT = "";
  };
}
