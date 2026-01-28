{
  inputs.nixpkgs = {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-23.05.tar.gz";
    flake = false;
  };
  outputs =
    { nixpkgs, ... }:
    {
      overlays.default =
        self: super:
        let
          pkgs = (
            import nixpkgs {
              inherit (self.stdenv) system;
              config = {
                permittedInsecurePackages = [ "nodejs-16.20.2" ];
              };
            }
          );
        in
        {
          inherit (pkgs) nodejs_16;
        };
    };
}
