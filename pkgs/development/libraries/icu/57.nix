args @ { stdenv, fetchurl, fetchpatch, fixDarwinDylibNames }:

import ./base.nix {
  version = "57.1";
  sha256 = "10cmkqigxh9f73y7q3p991q6j8pph0mrydgj11w1x6wlcp5ng37z";
  patches = [ ];
  patchFlags = "-p4";
} args
