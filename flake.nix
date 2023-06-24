{
  inputs = {
    # Add to your flake.nix:
    # nwg-look.inputs.nixpkgs.follows = nixpkgs;
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    xwaylandvideobridge-git = {
      url = "gitlab:davidedmundson/xwaylandvideobridge?host=invent.kde.org";
      flake = false;
    };
    kpipewire = {
      url = "gitlab:plasma/kpipewire?host=invent.kde.org";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, xwaylandvideobridge-git, kpipewire, ... }@inp:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in with pkgs; {
      xwaylandvideobridge = mkDerivation rec {
        pname = "xwaylandvideobridge";
        version = "unstable-2023-06-23";

        src = xwaylandvideobridge-git;

        nativeBuildInputs = [ cmake extra-cmake-modules pkg-config ];

        buildInputs = [
          qt5.qtbase
          qt5.qtquickcontrols2
          qt5.qtx11extras
          libsForQt5.kdelibs4support
          kpipewire
        ];

        dontWrapQtApps = true;
      };
    };

}
