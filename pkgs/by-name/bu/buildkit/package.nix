{
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "buildkit";
  version = "0.23.0";

  src = fetchFromGitHub {
    owner = "moby";
    repo = "buildkit";
    rev = "v${version}";
    hash = "sha256-yEIzXBwcct7+8Bqk5256ZNyWpSpCZwxVVyg5vua2Oj8=";
  };

  vendorHash = null;

  subPackages = [ "cmd/buildctl" ] ++ lib.optionals stdenv.hostPlatform.isLinux [ "cmd/buildkitd" ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/moby/buildkit/version.Version=${version}"
    "-X github.com/moby/buildkit/version.Revision=${src.rev}"
  ];

  doCheck = false;

  meta = {
    description = "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit";
    homepage = "https://github.com/moby/buildkit";
    changelog = "https://github.com/moby/buildkit/releases/tag/v${version}";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [
      developer-guy
      vdemeester
    ];
    mainProgram = "buildctl";
  };
}
