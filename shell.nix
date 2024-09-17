{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "Infra environemnt";

  # List of packages to install in this shell
  buildInputs = [
    pkgs.python3
    pkgs.python312Packages.pip
    pkgs.tenv
    pkgs.argocd
    pkgs.ansible
  ];

  # Environment variables (optional)
  shellHook = ''
    echo "Welcome to your development environment!"
    echo "python3, terraform, argocd and ansible are available."
  '';
}