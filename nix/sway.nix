# Tell it how it is

{ pkgs, inputs, home, system, ... }:

{
  imports = [ ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  home.packages = with pkgs; [
    swaylock
    swayidle
    wl-clipboard
    kitty
  ];
}
