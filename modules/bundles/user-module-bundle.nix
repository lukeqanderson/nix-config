{ 
  # user defined parameters
  ...
}: { pkgs, lib, ... }: {
  imports = [
    #( import ../system-modules/startup/auto-login-service.nix { default-user = default-user; } )
  ];
}
