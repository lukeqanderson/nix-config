These are all the files needed for NixOS configuration.

Manual steps:

sops-nix setup (secrets manager):

1. ```ssh-keygen -f ~/.ssh/private``` (if no ssh key, ssh key should have no password)
2. ```mkdir -p ~/.config/sops/age```
3. ```age-keygen -o ~/.config/sops/age/keys.txt```
4. ```nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/private > ~/.config/sops/age/keys.txt```
5. ```age-keygen -y ~/.config/sops/age/key.txt```
6. copy and paste the public key from step 5 and add it under the ```keys:``` section of ```/etc/nixos/hosts/<your-host>.sops.yaml``` for the host you are configuring.
7. in the "secrets" directory of the host you are configuring, run ```sudo sops secrets.yaml```. 
8. add the following secrets:

```
github:
  auth-token: <auth-token>
```

to use secrets run ```sudo cat /run/secrets/<secrets-path>```

To rebuild the system, run ```sudo nixos-rebuild --flake /etc/nixos#default```
