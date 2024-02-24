{ pkgs, ... }:

{
  
  imports = [
    ./common.nix
  ];

  home.username = "yigit";
  home.homeDirectory = "/home/yigit";

  home.packages = with pkgs; [
    #yigit
    steam # gaming
    ani-cli # anime
    ticktick # task manager
    path-of-building # path of building
  ];

  programs.git = {
    userName = "yigit";
    userEmail = "myigitaydin@protonmail.com";
  };

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

}
