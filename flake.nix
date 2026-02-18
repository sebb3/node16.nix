{
  inputs.nixpkgs = {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-23.05.tar.gz";
    flake = false;
  };

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      lib = (import nixpkgs { system = "x86_64-linux"; }).lib;
      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.permittedInsecurePackages = [ "nodejs-16.20.2" ];
        };
    in
    {
      overlays.default = final: prev: {
        nodejs_16 = (pkgsFor prev.stdenv.system).nodejs_16;
      };

      packages = lib.genAttrs systems (system: {
        default = (pkgsFor system).nodejs_16;
      });
    };
}
