{ lib, fetchFromGitHub, buildGoModule, nixosTests }:

buildGoModule rec {
  pname = "lego";
  version = "4.3.0";

  src = fetchFromGitHub {
    owner = "go-acme";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Hy9doHqKv8pPX/vTdII2F5onmCM8bpCvK4kOfFd+LNU=";
  };

  vendorSha256 = "sha256-MvMH8XyZnlxTFzoBf+SIPz1fVvJwwRjZ1rv6QYMLBMk=";

  doCheck = false;

  subPackages = [ "cmd/lego" ];

  buildFlagsArray = [
    "-ldflags=-X main.version=${version}"
  ];

  meta = with lib; {
    description = "Let's Encrypt client and ACME library written in Go";
    license = licenses.mit;
    homepage = "https://go-acme.github.io/lego/";
    maintainers = teams.acme.members;
  };

  passthru.tests.lego = nixosTests.acme;
}
