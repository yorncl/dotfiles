{ config, pkgs, ... }:

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
  ];

  # Dotfiles
  # mainly using symlinks, maybe I will migrate someday
  let
    lns = config.lib.mkOutOfStoreSymlink;
  in  {
    home.file.".config/nvim/" = lns ../../nvim
    home.file.".config/tmux/" = lns ../../tmux
    home.file.".config/mpv/" = lns ../../mpv
    home.file.".config/zathura/" = lns ../../mpv
    home.file.".config/hypr/" = lns ../../mpv
    home.file.".config/flameshot/" = lns ../../mpv
  }

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
