{ pkgs, ... }: {
 #  services.xserver.enable = true;
 #  services.xserver.displayManager.gdm.enable = true;
 #  services.xserver.desktopManager.gnome.enable = true;

 #  environment.systemPackages = with pkgs; [ 
 #    # xdg-desktop-portal-gtk
 #    gnomeExtensions.appindicator 
 #    gnome.adwaita-icon-theme 
 #    chromium
 #  ];
 #  # environment.gnome.excludePackages = (with pkgs; [
 #  #   xdg-desktop-portal-gnome
 #  #   xdg-desktop-portal-gtk
 #  # ]);

 #  services.udev.packages = with pkgs; [ 
 #    gnome.gnome-settings-daemon 
 #  ];

 #  # Wayland

	# xdg.portal.enable = true;
	# # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # KDE Plasma 6 is now available on unstable
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

	xdg.portal.enable = true;
}
