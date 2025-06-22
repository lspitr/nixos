{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixos-cli.nixosModules.nixos-cli ];

  nix.settings = {
    substituters = [ "https://watersucks.cachix.org" ];
    trusted-public-keys = [
      "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
    ];
  };

  environment.systemPackages = with pkgs; [
    nvd
    nix-output-monitor
  ];

  services.nixos-cli = {
    enable = true;
    prebuildOptionCache = false;
    config = {
      use_nvd = true;
      use_nom = true;
    };
  };
}
