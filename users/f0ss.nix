{ pkgs, ... }:

{
  
  imports = [
    ./common.nix
  ];

  home.username = "f0ss";
  home.homeDirectory = "/home/f0ss";

  home.packages = with pkgs; [
    # f0ss nsfw
    cryptomator # encrypt files
    librewolf
    mpv

  ];

  programs.git = {
    userName = "f0ss";
    userEmail = "jifainp@pm.me";
  };

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

}
