{    config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  #networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver = {
   enable = true;
   autoRepeatDelay = 190;
   autoRepeatInterval = 30;
   windowManager.i3 = {
     enable = true;
     extraPackages = with pkgs; [
        rofi
        i3status
        i3lock
        i3blocks
      ];
    };
  };

  #services.displayManager = {
  #  defaultSession = "none+i3";
  #};

  services.displayManager.ly.enable = true;


  ## Configure keymap in X11
  #services.xserver.xkb = {
  #  layout = "us";
  #  variant = "";
  #};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yrn = {
    isNormalUser = true;
    description = "yrn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # nix
    home-manager

    # apps
    alacritty
    fzf
    kitty
    obsidian
    zathura
    anki-bin
    fuzzel
    swaylock

    # display manager
    ly

    # de
    hyprpaper
    waybar
    wofi

    # dev
    rustup
    pkgs.llvmPackages_14.libcxxClang
    cmake
    gnumake
    pipenv
    python3
    nodejs
    git

    # virtualization
    qemu
    virtualbox
  ];

  programs.hyprland = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
  };

  programs.thunar = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    #extraConfig = ''
    #  set-window-option -g mode-keys vi

    #  set -g prefix C-a
    #  unbind C-b


    #  bind -r C-k resize-pane -U
    #  bind -r C-j resize-pane -D
    #  bind -r C-h resize-pane -L
    #  bind -r C-l resize-pane -R

    #  bind-key -n M-k select-pane -U
    #  bind-key -n M-j select-pane -D
    #  bind-key -n M-h select-pane -L
    #  bind-key -n M-l select-pane -R


    #  bind-key -n M-H previous-window
    #  bind-key -n M-L next-window

    #  set -g mouse

    #  set -g default-terminal "tmux-256color"
    #  set -ag terminal-overrides ",xterm-256color:RGB"
    #'';
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  users.users.yrn.shell = pkgs.zsh; 
  programs.zsh = {
    enable = true;
  };

  programs.fzf = {
    keybindings = true;
    fuzzyCompletion = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
