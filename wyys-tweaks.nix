{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = with inputs.nyxpkgs.nixosModules; [
    nyx-cache
    nyx-overlay
    nyx-registry
  ];

  nixpkgs.overlays = [ inputs.lix-module.overlays.default ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # Speed up network performance
  environment.etc."sysctl.conf".text = lib.mkForce ''
    # Increase the TCP receive and transmit buffer sizes
    net.core.rmem_max = 16777216
    net.core.wmem_max = 16777216

    # Enable TCP window scaling and timestamps
    net.ipv4.tcp_window_scaling = 1
    net.ipv4.tcp_timestamps = 1

    # Enable TCP selective acknowledgments
    net.ipv4.tcp_sack = 1

    # Increase the maximum number of open file descriptors
    fs.file-max = 65535

    #reduce latency of connections
    net.ipv4.tcp_fastopen = 3;
  '';
  boot.kernel.sysctl = {
    "vm.max_map_count" = 1048576;
  };
  boot.kernelParams = [
    "i915.enable_psr=0"
    "intel_pstate=passive"
  ];

  zramSwap.enable = true;

  services.fstrim = {
    enable = true;
    interval = "weekly"; # The default
  };

  programs.steam.enable = true;

  # nix-tweaks
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "lspiter" ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
  };
}
