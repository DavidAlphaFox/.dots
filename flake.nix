#           ▗▄▄▄       ▗▄▄▄▄    ▄▄▄▖
#           ▜███▙       ▜███▙  ▟███▛
#            ▜███▙       ▜███▙▟███▛
#             ▜███▙       ▜██████▛
#      ▟█████████████████▙ ▜████▛     ▟▙
#     ▟███████████████████▙ ▜███▙    ▟██▙
#            ▄▄▄▄▖           ▜███▙  ▟███▛
#           ▟███▛             ▜██▛ ▟███▛
#          ▟███▛               ▜▛ ▟███▛
# ▟███████████▛                  ▟██████████▙
# ▜██████████▛                  ▟███████████▛
#       ▟███▛ ▟▙               ▟███▛
#      ▟███▛ ▟██▙             ▟███▛
#     ▟███▛  ▜███▙           ▝▀▀▀▀
#     ▜██▛    ▜███▙ ▜██████████████████▛
#      ▜▛     ▟████▙ ▜████████████████▛
#            ▟██████▙       ▜███▙
#           ▟███▛▜███▙       ▜███▙
#          ▟███▛  ▜███▙       ▜███▙
#          ▝▀▀▀    ▀▀▀▀▘       ▀▀▀▘
#
# Implemented machines:
#   • exalt - Craptop converted for Nix hacking
#
# A fair bit of inspiraton from github:srid/nixos-config

{
  description = "dmadisetti meets NixOS";

  inputs = {
    # To update nixpkgs (and thus NixOS), pick the nixos-unstable rev from
    # https://status.nixos.org/
    #
    # This ensures that we always use the official nix cache.
    nixpkgs.url = github:nixos/nixpkgs/a7ecde854aee5c4c7cd6177f54a99d2c1ff28a31;
    nixos-hardware.url = github:NixOS/nixos-hardware/master;

    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Use "${builtins.getEnv "PWD" ""}/nix/sensitive" once allowed,
    # see: NixOS/nix#/3966
    sensitive.url = "/home/dylan/.dots/nix/sensitive";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, sensitive, ... }:
    let
      system = "x86_64-linux";
      # Add nixpkgs overlays and config here. They apply to system and home-manager builds.
      pkgs = import nixpkgs {
        inherit system;
        overlays = import ./nix/overlays.nix;
        config.allowUnfree = true;
      };
      wms = { i3 = "x"; sway = "wayland"; fb = "none"; xmonad = "x"; };
      homeConfig = user: userConfigs: wm: { ... }: {
        imports = [ (./nix/home + "/${user}.nix") ]
          ++ userConfigs
          ++ (if wms ? "${wm}" then [
          ./nix/home/display.nix
          (./nix/home + "/${wm}.nix")
        ] else [ ]);
      };
      mkComputer =
        { machineConfig
        , user ? "dylan"
        , wm ? ""
        , extraModules ? [ ]
        , userConfigs ? [ ]
        }: nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          # Arguments to pass to all modules.
          specialArgs = { inherit system inputs sensitive user; };
          modules = (
            [
              # System configuration for this host
              machineConfig
              ./nix/common.nix

              # home-manager configuration
              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users."${user}" = homeConfig user userConfigs wm
                  {
                    inherit inputs system pkgs;
                  };
              }
            ] ++ extraModules ++ (if wms ? "${wm}" then [
              ./nix/common/fonts.nix
              ./nix/common/head.nix
              (./nix + ("/display/" + wms."${wm}") + ".nix")
            ] else [ ])
          );
        };
    in
    {
      # The "name" in nixosConfigurations.${name} should match the `hostname`
      #
      nixosConfigurations = {
        mamba = mkComputer {
          machineConfig = ./nix/machines/mamba.nix;
          wm = "xmonad";
        };
        exalt = mkComputer {
          machineConfig = ./nix/machines/exalt.nix;
          wm = "xmonad";
        };
        slug = mkComputer {
          machineConfig = ./nix/machines/slug.nix;
        };
      };
    };
}
