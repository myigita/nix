{ pkgs, ... }: {

  services.xserver = {
    enable = true;
    xkb.layout = "tr";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [ 
    # xdg-desktop-portal-gtk
    gnomeExtensions.appindicator 
    gnome.adwaita-icon-theme 
    espanso-wayland
    rustdesk
    gnome-extension-manager
  ];

  environment.gnome.excludePackages = (with pkgs; [
    xdg-desktop-portal-gnome
  #   xdg-desktop-portal-gtk
  ]);

  services.udev.packages = with pkgs; [ 
    gnome.gnome-settings-daemon 
  ];

  # Wayland

	xdg.portal.enable = true;
	# xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

}
