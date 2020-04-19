{
  pkgs ? import <nixpkgs> {}
}:

let pkgs' = pkgs; in
let
  pkgs = pkgs'.extend(final: super: {
    libusb-01 = final.callPackage ./libusb-01.nix {};
    _0xFFFF = final.callPackage ./0xFFFF.nix {
      libusb = final.libusb-01;
    };
  });
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      _0xFFFF
    ];
  }
