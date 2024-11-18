{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[λ](bold green)";
        error_symbol = "[λ](bold red)";
      };
      elixir.symbol = "🔮 ";
      nix_shell = {
        format = "via [$symbol$state]($style) ";
        symbol = "❄️ ";
      };
      package.disabled = true;
    };
  };
}
