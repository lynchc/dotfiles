{
  programs.kitty = {
    enable = true;
    #theme = "spaceduck";
    settings = {
      font_family = "Cascadia Code";
      font_size = "10.8";
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      resize_debounce_time = "0";
      kitty_mod = "ctrl+alt";
      adjust_line_height = 0;
      adjust_column_width = 0;
      placement_strategy = "top-left";

      background =           "#000000";
      foreground =           "#e9e9e9";
      cursor =               "#e9e9e9";
      selection_background = "#424242";
      color0 =               "#000000";
      color8 =               "#000000";
      color1 =               "#d44d53";
      color9 =               "#d44d53";
      color2 =               "#b9c949";
      color10 =              "#b9c949";
      color3 =               "#e6c446";
      color11 =              "#e6c446";
      color4 =               "#79a6da";
      color12 =              "#79a6da";
      color5 =               "#c396d7";
      color13 =              "#c396d7";
      color6 =               "#70c0b1";
      color14 =              "#70c0b1";
      color7 =               "#fffefe";
      color15 =              "#fffefe";
      selection_foreground = "#000000";
    };
    keybindings = {
      "kitty_mod+RIGHT_BRACKET" = "change_font_size all +0.1";
      "kitty_mod+LEFT_BRACKET" = "change_font_size all -0.1";
      "kitty_mod+0" = "change_font_size all 0";
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };
  };
}
