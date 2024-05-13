{ config, pkgs, ... }:
{
  
  imports = [
    # Hyprland
    # inputs.hyprland.homeManagerModules.default
    # ../homemanager/hypr # points to ./hypr/default.nix # wayland

    # Espanso
    ../homemanager/espanso

    # Gnome Settings
    ../homemanager/gnome
  ];

  # programs.espanso.enable = true;

  home.packages = with pkgs; [
    # libsForQt5.kdeconnect-kde
    appimage-run
    cryptomator
    android-tools
    usbutils
    udiskie
    # playerctl
    # sptlrx
    # google-chrome
    flutter
    autossh
    fastfetch
    qmk
    # notesnook
    zoxide
    rustdesk-flutter
    libsForQt5.qt5.qtwayland # qt wayland
    ncspot # spotify cli
    fzf # fuzzy finder
    tldr # man but better
    libreoffice-fresh # office suite
    libsForQt5.okular # pdf viewer

    brightnessctl # control screen brightness
    nix-tree # dependancy tree
    ncdu # disk usage
    hyprshot # screenshot
    nvd # nix pkg diffs
    gnome.eog # image viewer
    glib # gnome settings (for dark mode with gnome apps)
    neofetch # system info
    neovim # text editor
    bitwarden-cli # password manage
    fish # shell
    gnome.nautilus # file manager // TODO CHOOSE ONE
    vivaldi # web browser
    kitty # terminal emulator
    mpd # music player
    pavucontrol # audio control

    # LunarVim
    gnumake
    (python3.withPackages (ps: with ps; [
      # numpy # these two are
      # scipy # probably redundant to pandas
      # jupyterlab
      # pandas
      # statsmodels
      # scikitlearn
      openai
      pip
      # django
    ]))
    nodejs_21
    cargo
    ripgrep
    neovim
    lunarvim

    obsidian # note taking

    libsForQt5.kdenlive # video editor
    godot_4 # game motor
    yt-dlp # youtube download
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
    ocrmypdf
    # jetbrains.idea-community-bin
  ];

  # Define common programs and settings here

  programs.java.enable = true;

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
    ];
  };

  programs.tmux = {
    shell = "${pkgs.fish}/bin/fish";
    enable = true;
    mouse = true; 
    # plugins = with pkgs;
    #   [
    #     tmuxPlugins.tpm
    #     tmuxPlugins.tmux-sensible
    #     christoomey.vim-tmux-navigator
    #     dreamsofcode-io.catppuccin-tmux
    #   ];
    extraConfig = ''
      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      # unbind ctrl+b as prefix and bind ctrl+space instead
      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      # terminal colors
      set-option -sa terminal-overrides ",xterm*:Tc"

      # # split into cwd
      # bind '"' split-window -v -c "#{pane_current_path}"
      # bind % split-window -h -c "#{pane_current_path}"

      # # catppuccin config
      # set -g @catppuccin_flavour 'mocha'

      #List of plugins
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'christoomey/vim-tmux-navigator'
      # set -g @plugin 'dreamsofcode-io/catppuccin-tmux'

      # Other examples:
      # set -g @plugin 'github_username/plugin_name'
      # set -g @plugin 'github_username/plugin_name#branch'
      # set -g @plugin 'git@github.com:user/plugin'
      # set -g @plugin 'git@bitbucket.com:user/plugin'

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.tmux/plugins/tpm/tpm'

      # Make split keys better
      unbind % 
      unbind '"'
      bind '\' split-window -h -c '#{pane_current_path}'           
      bind '-' split-window -v -c '#{pane_current_path}'

      # Quickly move through panes with ALT+Arrow Key
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # r to reload config
      unbind r
      bind r source-file ~/.tmux.conf \; display "Reloaded tmux config!"

      # Automatically set the window title
      set-window-option -g automatic-rename off

      # activity notifications
      setw -g monitor-activity on
      setw -g visual-activity on

      # Improve terminal colors
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"

      # Increase scrollback buffer to 10000
      set -g history-limit 10000
    '';
  };

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
			background_opacity = "0.7";
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
        upd="cd /shared/nix && nix flake update && sudo nixos-rebuild switch --flake /shared/nix/"; # update nixos
        nswitch="sudo nixos-rebuild switch --flake /shared/nix/"; # nixos-rebuild switch
        dir="dir --color"; # dir but better
        sship="ifconfig wlp0s20f3 | grep -oE 'inet ([0-9]{1,3}\.){3}[0-9]{1,3}' | awk '{print $2}'"; # get local ip
        sshi="ssh -i ~/.ssh/zinism-ssh-key-private"; # ssh
        ls="ls --color -la"; # ls but better
        hgrep="history | grep";
        autossh_auto="autossh -M 0 -o 'ServerAliveInterval 30' -o 'ServerAliveCountMax 3' -R 43022:localhost:22 root@45.77.136.126 -i ~/.ssh/zinism-ssh-key-private -f";
        # gitbup="git add . && git commit -m '' && git push -u origin main";
    };
    shellInit = ''
      zoxide init fish | source
      starship init fish | source
    '';
    functions = {
      fish_prompt = '' 
      set -l nix_shell_info 
        (
          if test -n "$IN_NIX_SHELL"
            echo -n "<nix-shell> "
          end
        )

      echo -n -s "$nix_shell_info ~>"
      '';
    };
  };

  programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        format = "($all)$character";

        add_newline = false;

        line_break = {
          disabled = true;
        };

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
      size = 14;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
      # "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      # "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      # "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  services.megasync.enable = true;

  home.sessionVariables.GTK_THEME = config.gtk.theme.name;
  home.sessionVariables.EDITOR = "vim";

  # Ensure home-manager is enabled
  programs.home-manager.enable = true;

  # config.programs.mosh = { # mobile shell for ssh
  #   enable = true;
  # };

  # nixpkgs.overlays = [ # until catppuccin is merged
  #     (final: prev: {
  #       pythonPackagesExtensions =
  #         prev.pythonPackagesExtensions
  #         ++ [
  #           (
  #             python-final: python-prev: {
  #               catppuccin = python-prev.catppuccin.overridePythonAttrs (oldAttrs: rec {
  #                 version = "1.3.2";
  #                 src = prev.fetchFromGitHub {
  #                   owner = "catppuccin";
  #                   repo = "python";
  #                   rev = "refs/tags/v${version}";
  #                   hash = "sha256-spPZdQ+x3isyeBXZ/J2QE6zNhyHRfyRQGiHreuXzzik=";
  #                 };

  #                 # can be removed next version
  #                 disabledTestPaths = [
  #                   "tests/test_flavour.py" # would download a json to check correctness of flavours
  #                 ];
  #               });
  #             }
  #           )
  #         ];
  #     })
  #   ];
}

