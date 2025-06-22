{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prismlauncher
    jdk21
    jdk17
    jdk8

    discord

    obs-studio
    kdenlive

    spotify
    spotifyd
    libreoffice-qt
    p7zip
    torrent7z

    kitty
    picom-pijulius
    zsh
    git
    wget
    fastfetch
    nixd
    nixfmt-rfc-style
    resources
    filezilla
  ];
}
