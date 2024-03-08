{ pkgs, ... }: {

  services.xserver = {
    enable = true;
    xkb.layout = "tr";
    displayManager.gdm.enable = true;
    # displayManager.gdm.wayland = false;
    desktopManager.gnome.enable = true;
  };
   
  environment.systemPackages = with pkgs; [ 
    # xdg-desktop-portal-gtk
    gnomeExtensions.appindicator 
    gnome.adwaita-icon-theme 
    chromium
    espanso-wayland
    rustdesk
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
