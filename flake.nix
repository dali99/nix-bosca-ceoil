{
  description = "A flake for running bosca-ceoil in wine";

  inputs.erosanix.url = "github:emmanuelrosa/erosanix";

  outputs = { self, nixpkgs, erosanix }: {
    packages.x86_64-linux = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in with (pkgs // erosanix.lib.x86_64-linux); {
      bosca-ceoil = callPackage ./bosca-ceoil.nix {
        inherit mkWindowsApp;
        wine = wineWowPackages.full;
      };
    };
    apps.x86_64-linux.bosca-ceoil = {
      type = "app";
      program = "${self.packages.x86_64-linux.bosca-ceoil}/bin/bosca-ceoil";
    };
    
    apps.x86_64-linux.default = self.apps.x86_64-linux.bosca-ceoil;
  };
}
