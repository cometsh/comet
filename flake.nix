{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    forSystems = fn:
      nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ] (system: fn nixpkgs.legacyPackages.${system});
    defaultForSystems = fn: forSystems (pkgs: {default = fn pkgs;});
  in {
    devShells = defaultForSystems (pkgs:
      pkgs.mkShell {
        nativeBuildInputs = with pkgs; [nodejs_22 bun elixir erlang];
      });
  };
}
