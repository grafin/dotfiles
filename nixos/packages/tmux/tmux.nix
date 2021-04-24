{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    terminal = "screen-256color";
    newSession = true;
    extraConfig = ''
run-shell ${pkgs.tmuxPlugins.sensible.rtp}
run-shell ${pkgs.tmuxPlugins.resurrect.rtp}
run-shell ${pkgs.tmuxPlugins.continuum.rtp}
run-shell ${pkgs.tmuxPlugins.yank.rtp}

set -g mouse on
set -g @yank_selection_mouse 'clipboard'
set -g focus-events on
set -g mode-keys vi
set -g @continuum-restore 'on'
    '';
  };
}
