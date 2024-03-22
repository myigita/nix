{ pkgs, ... }: {

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

	xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-kde pkgs.xdg-desktop-portal];

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
    wayvnc # remote desktop
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprland
    swww
    waybar
    # eww
    swaynotificationcenter
    swaylock # lockscreen
    swayidle
    rofi-wayland # app launcher
    rofi-calc # calculator for rofi doesnt work tho

    #other
    # espanso-wayland # fucking shit
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
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';
}
