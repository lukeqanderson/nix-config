These are all the files needed for NixOS configuration.

Manual steps:

sops-nix setup (secrets manager):

1. ```nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt```
2. ```nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/private > ~/.config/sops/age/keys.txt```
3. ```nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt```

To build to rebuild the system, run ```sudo nixos-rebuild --flake /etc/nixos#default```
