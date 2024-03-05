{ config, pkgs, lib, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "squid"; 

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "trq";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yigit = {
    isNormalUser = true;
    description = "yigit";
    extraGroups = [ "networkmanager" "wheel" "input"];
  };

 users.users.f0ss = {
    isNormalUser = true;
    description = "f0ss";
    extraGroups = [ "networkmanager" "wheel" "input"];
  };

  users.users.yokul = {
    isNormalUser = true;
    description = "yokul";
    extraGroups = [ "networkmanager" "wheel" "input"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	# basic stuff
	wget
	git
	curl
	vim
  zip
  unzip
  htop
  nwg-look
  sassc
  desktop-file-utils
  corefonts
  wev # key presses
  busybox # common unix commands
	blueman
	lshw # for nvidia optimus shit idk
  networkmanagerapplet
  vulkan-tools
  glxinfo
  mesa
	gtk3
  nvidia-offload
  openssl
  openssl.dev
  pkg-config
  rustc

  # DE
	xdg-desktop-portal-gtk
	xdg-desktop-portal-hyprland
	hyprland
	swww
	waybar
	eww
	dunst
	libnotify
  swayidle

  ];


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "23.11"; # Did you read the comment?

	# Custom
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
	services.blueman.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Hyprland & Nvidia

	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	environment.sessionVariables = {
		WLR_NO_HARDWARE_CURSORS = "1";
		NIXOS_OZONE_WL = "1";
    NIX_LD = "/run/current-system/sw/share/nix-ld/lib/ld.so";
    NIX_LD_LIBRARY_PATH = "/run/current-system/sw/share/nix-ld/lib";
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
	};

	hardware.opengl = {
		enable = true;
		driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ 
      vulkan-loader 
      vulkan-validation-layers 
      vulkan-extension-layer 
      vulkan-tools 
    ];
	};

	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia = {
		modesetting.enable = true;

		powerManagement.enable = true;
		# Fine-grained power management. Turns off GPU when not in use.
		# Experimental and only works on modern Nvidia GPUs (Turing or newer).
		powerManagement.finegrained = false;

		# Use the NVidia open source kernel module (not to be confused with the
		# independent third-party "nouveau" open source driver).
		open = false;

		# Enable the Nvidia settings menu,
		# accessible via `nvidia-settings`.
		nvidiaSettings = true;

		# Optionally, you may need to select the appropriate driver version for your specific GPU.
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};

	xdg.portal.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

	hardware.nvidia.prime = {
		offload = {
			enable = true;
			enableOffloadCmd = true;
		};
    # sync.enable = true;
		# Make sure to use the correct Bus ID values for your system!
		intelBusId = "PCI:0:2:0";
		nvidiaBusId = "PCI:1:0:0";
	};

	fonts.packages = with pkgs; [
		noto-fonts
 		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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

  security.pam.services.swaylock = { 
  };


  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
  ];
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    # gamescopeSession.enable = true;
  };

  powerManagement.enable = true;
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

     #Optional helps save long term battery health
     START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
     STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };
}
