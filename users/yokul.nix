{ pkgs, ... }:

{
  
  imports = [
    ./common.nix
  ];

  home.username = "yokul";
  home.homeDirectory = "/home/yokul";

  home.packages = with pkgs; [
    #okul
    racket # drracket scheme for school
    ticktick # task manager
  ];

  programs.git = {
    userName = "maydin20";
    userEmail = "maydin20@ku.edu.tr";
  };

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
  
}
