{ config, inputs, pkgs, ... }:

{
  
  imports = [
    inputs.hyprland.homeManagerModules.default
    # ../homemanager/hypr # points to ./hypr/default.nix
  ];
  
  home.packages = with pkgs; [
    ncspot # spotify cli
    fzf # fuzzy finder
    tldr # man but better
    # rustdesk # todo doesnt work
    libreoffice-fresh # office suite
    libsForQt5.okular # pdf viewer

    tmux # terminal multiplexer
    brightnessctl # control screen brightness
    appimage-run # run appimages
    swaylock # lockscreen
    nix-tree # dependancy tree
    ncdu # disk usage
    hyprshot # screenshot
    nvd # nix pkg diffs
    gnome.eog # image viewer
    glib # gnome settings (for dark mode with gnome apps)
    neofetch # system info
    neovim # text editor
    bitwarden # password manager // TODO choose one
    bitwarden-cli
    megasync # cloud storage
    fish # shell
    gnome.nautilus # file manager // TODO CHOOSE ONE
    vivaldi # web browser
    kitty # terminal emulator
    libsForQt5.qt5.qtwayland # qt wayland
    # qt6Packages.sddm
    wl-clipboard # clipboard
    mpd # music player
    pavucontrol # audio control
    rofi-wayland # app launcher
    rofi-calc # calculator for rofi doesnt work tho

    # LunarVim
    gnumake
    (python311.withPackages (ps: with ps; [
      numpy # these two are
      scipy # probably redundant to pandas
      jupyterlab
      pandas
      statsmodels
      scikitlearn
      openai
      pip
    ]))
    nodejs_21
    cargo
    ripgrep
    neovim
    lunarvim

    obsidian # note taking

    espanso-wayland # fucking shit

    libsForQt5.kdenlive # video editor
    godot_4 # game motor
    yt-dlp # youtube download
    mpvpaper # video wallpaper
    starship # cli prompt
    ranger # file manager cli
    catppuccin-gtk
    papirus-icon-theme
    firefox
    racket # //TODO REMOVE 
    pkg-config
    openssl
    rustc
    calibre
    ollama
    ocrmypdf
  ];

  # Define common programs and settings here
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

	programs.kitty = {
		enable = true;
		font = {
			name = "JetBrainsMono Nerd Font";
			size = 13;
		};
		# theme = "Catppuccin-Mocha";
		# theme = "kanagawa";
		shellIntegration.enableFishIntegration = true;
    settings = {
			tab_bar_style = "fade";
			tab_fade = "0.25 0.5 0.75 1";
			background_opacity = "0.5";
    };
    extraConfig =
    ''
      include = /shared/nix/homemanager/kitty/kanagawa.conf;
      background #1F1F28
      foreground #DCD7BA
      selection_background #2D4F67
      selection_foreground #C8C093
      url_color #72A7BC
      cursor #C8C093

      # Tabs
      active_tab_background #2D4F67
      active_tab_foreground #DCD7BA
      inactive_tab_background #223249
      inactive_tab_foreground #727169
      #tab_bar_background #15161E

      # normal
      color0 #090618
      color1 #C34043
      color2 #76946A
      color3 #C0A36E
      color4 #7E9CD8
      color5 #957FB8
      color6 #6A9589
      color7 #C8C093

      # bright
      color8  #727169
      color9  #E82424
      color10 #98BB6C
      color11 #E6C384
      color12 #7FB4CA
      color13 #938AA9
      color14 #7AA89F
      color15 #DCD7BA


      # extended colors
      color16 #FFA066
      color17 #FF5D62
      '';
		
	};

  programs.fish = {
    enable = true;
    shellAliases = {
        upd="cd /shared/nix && nix flake update && sudo nixos-rebuild switch --flake /shared/nix/";
        nswitch="sudo nixos-rebuild switch --flake /shared/nix/";
        dir="dir --color";
    };
    shellInit = ''
      starship init fish | source
    '';
  };

  programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        
        username = {
          show_always = true;
        };

        palette = "catppuccin_mocha"; # idk if necessary, i think kitty or fish config already takes care of ths

        palettes.catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Mauve-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        size = "standard";
        tweaks = [ "black" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.sessionVariables.GTK_THEME = config.gtk.theme.name;
  home.sessionVariables.EDITOR = "vim";
  # Ensure home-manager is enabled
  programs.home-manager.enable = true;
}

