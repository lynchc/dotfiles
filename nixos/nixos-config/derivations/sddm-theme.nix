{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation {
  pname = "my-theme";
  version = "53f81e3";
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src/sddm/Bitpunk $out/share/sddm/themes/my-theme
  '';
  src = fetchFromGitHub {
    owner = "bitr8";
    repo = "bitpunk-theme";
    rev = "fd3a3b56be2ec555b664b3dbbe5bc2e6b7d96eeb";
    sha256 = "Yh49G8f3s6iwWMTK1llpqJXJ9rW0bdmI1aWCl/WLd+0=";
  };
}
