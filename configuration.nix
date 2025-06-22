{ pkgs, ... }:
{
  imports = [
    ./bootloader.nix
    ./locale.nix
    ./graphics.nix
    ./pipewire.nix
    ./wyys-tweaks.nix
    ./nixos-cli.nix
    ./plasma.nix
    ./hardware-configuration.nix
    ./pkgs.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  services = {
    flatpak.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
  };

  # Hint to electron apps to use wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lspiter = {
    isNormalUser = true;
    description = "lspiter";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ kate ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    firefox.enable = true;
    gamemode.enable = true;
    kdeconnect.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
