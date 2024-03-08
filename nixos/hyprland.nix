{ pkgs, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

	xdg.portal.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  security.pam.services.swaylock = { 
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #   ];
  # };

  # security = {
  #   polkit.enable = true;
  #   pam.services.ags = {};
  # };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprland
    swww
    waybar
    eww
    swaynotificationcenter
    # dunst
    # libnotify
    hypridle
  ];

  services.greetd = {
    enable = true;
    restart = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "yigit";
      };
     };
  };


  # systemd = {
  #   user.services.polkit-gnome-authentication-agent-1 = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #       Restart = "on-failure";
  #       RestartSec = 1;
  #       TimeoutStopSec = 10;
  #     };
  #   };
  # };

#   services = {
#     gvfs.enable = true;
#     devmon.enable = true;
#     udisks2.enable = true;
#     upower.enable = true;
#     power-profiles-daemon.enable = true;
#     accounts-daemon.enable = true;
#     gnome = {
#       evolution-data-server.enable = true;
#       glib-networking.enable = true;
#       gnome-keyring.enable = true;
#       gnome-online-accounts.enable = true;
#     };
#   };
}
