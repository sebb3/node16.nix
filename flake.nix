{
  inputs.nixpkgs = {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-23.05.tar.gz";
    flake = false;
  };
  outputs =
    { nixpkgs, ... }:
    {
      overlays.default =
      let pkgs = p: import nixpkgs {
        inherit (p.stdenv) system;
        config = {
          permittedInsecurePackages = [
            "nodejs-16.20.2"
          ];
        };
      };
      in
        final: prev: {
          nodejs_16 = (pkgs prev).nodejs_16;
        };
    };
}
