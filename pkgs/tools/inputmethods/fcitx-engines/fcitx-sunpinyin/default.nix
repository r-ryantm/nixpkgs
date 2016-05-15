{ stdenv, fetchurl, cmake, fcitx, sunpinyin, gettext, pkgconfig }:

stdenv.mkDerivation rec {
  name = "fcitx-sunpinyin-${version}";
  version = "0.4.1";

  src = fetchurl {
    url = "https://download.fcitx-im.org/fcitx-sunpinyin/fcitx-sunpinyin-${version}.tar.xz";
    sha256 = "7bd0c61a3c821719760bff72c3c114b28e277b87f54dcb61d83e3548b1eb6777";
  };

  patches = [ ./cmake.patch ];

  buildInputs = [ cmake fcitx sunpinyin gettext pkgconfig ];

  preConfigure = ''
   echo $PKG_CONFIG_PATH
  '';

  preInstall = ''
    substituteInPlace src/cmake_install.cmake \
      --replace ${fcitx} $out
  '';

  meta = with stdenv.lib; {
    isFcitxEngine = true;
    description   = "Fcitx Wrapper for sunpinyin";
    license       = licenses.gpl2Plus;
    platforms     = platforms.linux;
    maintainers   = with maintainers; [ ryantm ];
  };

}
