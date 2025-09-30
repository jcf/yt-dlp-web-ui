{ lib
, stdenv
, nodejs
, pnpm
}:
let common = import ./common.nix { inherit lib; }; in
stdenv.mkDerivation (finalAttrs: {
  pname = "yt-dlp-web-ui-frontend";

  inherit (common) version;

  src = lib.fileset.toSource {
    root = ../frontend;
    fileset = ../frontend;
  };

  buildPhase = ''
    npm run build
  '';

  installPhase = ''
    mkdir -p $out/dist
    cp -r dist/* $out/dist
  '';

  nativeBuildInputs = [
    nodejs
    pnpm.configHook
  ];

  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-Gwjdx1l9Q495FAk9DWgoW5X/7Qe40FcmdsWsG/Ee8WY=";
  };

  inherit (common) meta;
})
