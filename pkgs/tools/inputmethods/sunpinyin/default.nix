{ stdenv, fetchurl, fetchgit, sqlite, scons, pkgconfig, python, perl }:

stdenv.mkDerivation rec {
 name = "sunpinyin-${version}";
 version = "2.0.3.20160226";

  meta = with stdenv.lib; {
    description = "Input method engine for Chinese";
    maintainers = with stdenv.lib.maintainers; [ ryantm ];
    homepace    = https://github.com/sunpinyin/sunpinyin;
    license     = licenses.lgpl21;
    platforms   = platforms.linux;
  };

  buildInputs = [ scons pkgconfig python perl ];

  propagatedBuildInputs = [ sqlite ];

  preConfigure = ''
   sed -i 's|/usr/bin/python|${python}/bin/python|' $(find -name \*.py)

   substituteInPlace SConstruct \
      --replace /usr/local $out
   substituteInPlace wrapper/ibus/SConstruct \
      --replace /usr/local $out
   substituteInPlace wrapper/scim/SConstruct \
      --replace /usr/local $out
   substituteInPlace wrapper/xim/SConstruct \
      --replace /usr/local $out
  '';

  buildPhase = "scons";

  installPhase = "scons install";

  src = fetchgit {
    url = "https://github.com/sunpinyin/sunpinyin.git";
    rev = "844ad0fe49751d6a09fdfe531668769b06c66459";
    sha256 = "0a9cn8s111jxfv10ry37anl9lnb5icda2v14jzxxjbahbigrifb8";
  };

}
