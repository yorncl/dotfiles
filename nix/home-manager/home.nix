{ config, pkgs, ... }:
let
    dotfiles = "${config.home.homeDirectory}/.dotfiles/";
    lns = config.lib.file.mkOutOfStoreSymlink;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yrn";
  home.homeDirectory = "/home/yrn";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.discord
    pkgs.spotify
  ];

  # services.flameshot = {
  #   enable = true;
  #   settings.General = {
  #     showStartupLaunchMessage = false;
  #     saveLastRegion = true;
  #   };
  # };

  # Dotfiles
  # mainly using symlinks, maybe I will migrate someday
  home.file.".config/nvim" = {source = lns "${dotfiles}/nvim";};
  home.file.".config/tmux" = {source = lns "${dotfiles}/tmux";};
  home.file.".config/hypr" = {source = lns "${dotfiles}/hypr";};

  home.file.".config/mpv/input.conf".text = ''
    RIGHT no-osd seek  1 exact
    LEFT  no-osd seek -1 exact

    S seek 0 absolute
  '';

  home.file.".config/zathura/zathurarc".text = ''
      map <C-I> recolor
      map <A-b> feedkeys ":blist"<Return>
      # Write
      map <A-A> feedkeys ":bmark a"<Return>
      map <A-S> feedkeys ":bmark s"<Return>
      map <A-D> feedkeys ":bmark d"<Return>
      map <A-F> feedkeys ":bmark f"<Return>
      # Read
      map <A-a> feedkeys ":blist a"<Return>
      map <A-s> feedkeys ":blist s"<Return>
      map <A-d> feedkeys ":blist d"<Return>
      map <A-f> feedkeys ":blist f"<Return>
      # New instance (use it as new tab, flemme d'installer tabbed)
      map <C-t> feedkeys ":exec zathura $FILE"<Return>
      set selection-clipboard clipboard
    '';

  home.file.".config/alacritty/alacritty.toml".text = ''
    [window]
    opacity = 0.95
    [env]
    term = "xterm-256color"
  '';

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "yornclaudel@gmail.com";
    userName = "Martin Claudel";
  };

  programs.zsh.enable = true;

  programs.zsh.prezto = {
    enable = true;
    pmodules = [
      "environment"
      "terminal"
      "editor"
      "history"
      "directory"
      "spectrum"
      "utility"
      "git"
      "completion"
      "prompt"
    ];
  };

  programs.fzf = {
	  enable = true;
	  enableZshIntegration = true;
  };

  
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        font-family: ${config.stylix.fonts.monospace.name};
        font-size: 13px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: @base00;
        color: @base05;
        border-bottom: 2px solid @base02;
      }

      #workspaces button {
        padding: 0 5px;
        color: @base05;
      }

      #workspaces button.active {
        background: @base02;
      }

      #workspaces button.urgent {
        background: @base08;
      }

      #mode {
        background: @base0A;
        color: @base00;
      }

      #clock, #battery, #cpu, #memory, #network, #pulseaudio, #custom-spotify, #tray, #mode {
        padding: 0 10px;
        margin: 0 5px;
      }

      #clock {
        background-color: @base0C;
        color: @base00;
      }

      #battery {
        background-color: @base0B;
        color: @base00;
      }

      #battery.charging {
        background-color: @base0B;
      }

      #battery.warning:not(.charging) {
        background-color: @base0A;
      }

      #battery.critical:not(.charging) {
        background-color: @base08;
      }

      #cpu {
        background-color: @base0D;
        color: @base00;
      }

      #memory {
        background-color: @base0E;
        color: @base00;
      }

      #network {
        background-color: @base0B;
        color: @base00;
      }

      #network.disconnected {
        background-color: @base08;
      }

      #pulseaudio {
        background-color: @base0C;
        color: @base00;
      }

      #pulseaudio.muted {
        background-color: @base02;
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/mode"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "cpu"
          "memory"
          "network"
          "pulseaudio"
          "battery"
          "tray"
        ];
        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          sort-by-number = true;
          active-only = false;
        };
        "clock" = {
          format = "{:%H:%M %Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "cpu" = {
          format = "CPU {usage}%";
          tooltip = false;
        };
        "memory" = {
          format = "RAM {}%";
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "BAT {capacity}%";
          format-charging = "CHR {capacity}%";
          format-plugged = "PLG {capacity}%";
        };
        "network" = {
          format-wifi = "WiFi ({signalStrength}%)";
          format-ethernet = "ETH";
          format-disconnected = "NET DOWN";
          tooltip-format = "{ifname} via {gwaddr}";
        };
        "pulseaudio" = {
          format = "VOL {volume}%";
          format-muted = "MUTE";
          on-click = "pavucontrol";
        };
      };
    };
  };
}
