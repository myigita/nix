{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [ 
    gnomeExtensions.appindicator 
    gnome.adwaita-icon-theme 
  ];

  services.udev.packages = with pkgs; [ 
    gnome.gnome-settings-daemon 
  ];
}
