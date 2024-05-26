{ home, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "pop-shell@system76.com"
        "blur-my-shell@aunetx"
        "mediacontrols@cliffniff.github.com"
        # "openbar@neuromorph"
        # "gsconnect@andyholmes.github.io"
      ];
    };
  }; 

  home.packages = with pkgs; [
    # ...
    gnomeExtensions.user-themes
    # gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
    # pop-launcher # crashes idk why
    gnome.gnome-tweaks
    gnomeExtensions.media-controls
    gnomeExtensions.blur-my-shell
    # gnomeExtensions.open-bar
  ];
}
